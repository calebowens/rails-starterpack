class Authentication::Components::LoginForm < ApplicationView
  def initialize(submission:)
    @submission = submission
  end

  def template
    form_with(url: authentication_login_path, id: "login") do |f|
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
