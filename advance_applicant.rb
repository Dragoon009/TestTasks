require 'pry'

class AdvanceApplicant

  def initialize(text_eval)
    @text_eval = text_eval
  end

  def advance_applicant(email, stage = nil)
    return error_message unless @text_eval.email_list.include?(email)
    return error_message if !stage.nil? && !@text_eval.stages.include?(stage) 
    if stage
      index = @text_eval.stages.index(stage) 
      if @text_eval.applicants[email] == index
        @text_eval.output += "\nAlready in #{stage}"
      else
        @text_eval.applicants[email] = index
        @text_eval.output += "\nADVANCE #{email}"
      end
    else
      if @text_eval.applicants[email] >= @text_eval.stages.count - 1 
        @text_eval.output += "\nAlready in #{@text_eval.applicants[email]&.last}"
      else
        @text_eval.applicants[email] += 1
        @text_eval.output += "\nADVANCE #{email}"
      end
    end
  end

end    