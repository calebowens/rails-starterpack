class Authentication::Views::Login < ApplicationView
  def initialize(submission: Submission.blank)
    @submission = submission
  end

  def template
    h1 { "Login" }

    render Authentication::Components::LoginForm.new(submission: @submission)
  end
end
