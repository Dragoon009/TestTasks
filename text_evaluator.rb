require_relative 'create_applicant'
require_relative 'advance_applicant'
require_relative 'decide_applicant'
require_relative 'display_stats'

class TextEvaluator

  attr_accessor :email_list, :stages, :output, :hired, :rejected, :error, :applicants

  AVAILABLE_STAGES = %w[ManualReview PhoneInterview BackgroundCheck DocumentSigning]

  def initialize(text)
    @text = text
    @email_list = []
    @stages = []
    @output = ""
    @hired = 0
    @rejected = 0
    @error = nil
    @applicants = { }
  end

  def parse_input
    @commands = @text.split("\n")
    
    set_stages
    return "Empty input" if @stages.length == 0
    @commands.each do |command|
      command = command.split(" ")
      case command[0]
      when "CREATE"
        CreateApplicant.new(self).find_or_create_applicant(command[1])               
      when "ADVANCE"
        AdvanceApplicant.new(self).advance_applicant(command[1], command[2])
      when "DECIDE"
        DecideApplicant.new(self).decide_applicant(command[1], command[2])
      when "STATS"
        DisplayStats.new(self).display_stats
      else
        error_message
      end
      return @output if @error
    end
    @output
  end

  def error_message
    @output = "Wrong input"
    @error = true
  end

  def set_stages
    if !@commands[0]&.start_with? "DEFINE"
      return error_message
    else
      stages = @commands[0].split(" ")
      stages.shift
      stages.each do |stage|
        @stages << stage if AVAILABLE_STAGES.include? stage 
      end
      @output += "DEFINE #{@stages.join(' ')}"
    end
    @commands.shift
  end

  # def find_or_create_applicant(email)
  #   return error_message if email.nil?
  #   @email_list << email
  #   if @email_list.count(email) > 1
  #     @email_list = @email_list.uniq
  #     @output += "\nDuplicate applicant"
  #   else
  #     @applicants[email] = 0
  #     @output += "\nCREATE #{email}"
  #   end
  # end

  def advance_applicant(email, stage = nil)
    return error_message unless @email_list.include?(email)
    return error_message if !stage.nil? && !@stages.include?(stage) 
    if stage
      index = @stages.index(stage) 
      if @applicants[email] == index
        @output += "\nAlready in #{stage}"
      else
        @applicants[email] = index
        @output += "\nADVANCE #{email}"
      end
    else
      if @applicants[email] >= @stages.count - 1 
        @output += "\nAlready in #{@applicants[email]&.last}"
      else
        @applicants[email] += 1
        @output += "\nADVANCE #{email}"
      end
    end
  end

  def decide_applicant(email, decision)
    return error_message unless @email_list.include?(email)
    if decision == "0" 
      @rejected += 1
      @applicants[email] = 0  
      @output += "\nRejected #{email}"
    elsif decision == "1" && @applicants[email] >= @stages.count - 1
      @hired += 1
      @applicants[email] = 0 
      @output += "\nHired #{email}"
    else
      @output += "\nFailed to decide for #{email}"
    end
  end

  def display_stats
    stats = "\n"
    @stages.each do |stage|
      amount = @applicants.values.flatten.count(@stages.index(stage))
      stats += "#{stage} #{amount} "
    end
    stats += "Hired #{@hired} Rejected #{@rejected}"
    @output += stats
  end

end