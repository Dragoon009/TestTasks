class DecideApplicant

  def initialize(text_eval)
    @text_eval = text_eval
  end

  def decide_applicant(email, decision)
    return error_message unless @text_eval.email_list.include?(email)
    if decision == "0" 
      @text_eval.rejected += 1
      @text_eval.applicants[email] = 0  
      @text_eval.output += "\nRejected #{email}"
    elsif decision == "1" && @applicants[email] >= @stages.count - 1
      @text_eval.hired += 1
      @text_eval.applicants[email] = 0 
      @text_eval.output += "\nHired #{email}"
    else
      @text_eval.output += "\nFailed to decide for #{email}"
    end
  end

end