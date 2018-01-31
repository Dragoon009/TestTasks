class CreateApplicant

  def initialize(text_eval)
    @text_eval = text_eval
  end

  def find_or_create_applicant(email)
    @text_eval.email_list << email
    if @text_eval.email_list.count(email) > 1
      @text_eval.output += "\nDuplicate applicant"
      @text_eval.email_list = @text_eval.email_list.uniq
    else
      @text_eval.applicants[email] = 0
      @text_eval.output = "\nCREATE #{email}"
    end
  end
  
end