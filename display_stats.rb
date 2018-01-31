require 'pry'

class DisplayStats

  def initialize(text_eval)
    @text_eval = text_eval
  end

  def display_stats
    stats = "\n"
    @text_eval.stages.each do |stage|
      amount = @text_eval.applicants.values.flatten.count(@text_eval.stages.index(stage))
      stats += "#{stage} #{amount} "
    end
    stats += "Hired #{@text_eval.hired} Rejected #{@text_eval.rejected}"
    binding.pry
    @text_eval.output += stats
  end

end    