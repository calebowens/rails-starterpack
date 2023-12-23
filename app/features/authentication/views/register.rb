class Authentication::Views::Register < ApplicationView
  def initialize(submission: Submission.blank)
    @submission = submission
  end

  def template
    h1 { "Create a user" }

    render Authentication::Components::RegisterForm.new(submission: @submission)
  end
end
