class Authentication::Views::Login < ApplicationView
  def initialize(submission: Submission.blank)
    @submission = submission
  end

  def template
    h1 { "Login" }

    turbo_frame_tag(:register) do
      form_with(url: authentication_login_path) do |f|
        f.label :email, "Email"
        f.text_field :email, value: @submission[:email]
        render @submission.errors_for(:email)

        f.label :password, "Password"
        f.password_field :password
        render @submission.errors_for(:password)

        f.submit "Login"
      end
    end
  end
end
