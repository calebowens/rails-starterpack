class Authentication::Views::Register < ApplicationView
  def initialize(email: nil, errors: {})
    @email = email
    @errors = errors
  end

  def template
    h1 { "Create a user" }

    turbo_frame_tag(:register) do
      form_with(url: authentication_register_path) do |f|
        f.label :email, "Email"
        f.text_field :email, value: @email
        display_errors :email

        f.label :password, "Password"
        f.password_field :password
        display_errors :password

        f.label :confirm_password, "Confirm Password"
        f.password_field :confirm_password
        display_errors :confirm_password

        f.submit "Register"
      end
    end
  end

  def display_errors(key)
    if @errors[key].present?
      @errors[key].each do |error|
        p { error }
      end
    end
  end
end
