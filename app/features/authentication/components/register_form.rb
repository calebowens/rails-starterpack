class Authentication::Components::RegisterForm < ApplicationView
  def initialize(submission:)
    @submission = submission
  end

  def template
    form_with(url: authentication_register_path, id: "register") do |f|
      f.label :email, "Email"
      f.text_field :email, value: @submission[:email]
      render @submission.errors_for(:email)

      f.label :password, "Password"
      f.password_field :password
      render @submission.errors_for(:password)

      f.label :confirm_password, "Confirm Password"
      f.password_field :confirm_password
      render @submission.errors_for(:confirm_password)

      f.submit "Register"
    end
  end
end
