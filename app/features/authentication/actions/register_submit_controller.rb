class Authentication::Actions::RegisterSubmitController < ApplicationController
  def handle
    errors = {email: [], password: [], confirm_password: []}

    email = user_params[:email] || ""
    password = user_params[:password] || ""
    confirm_password = user_params[:confirm_password] || ""

    errors[:email] << "Email cannot be left blank" if email.blank?
    errors[:email].push(*ValidatesEmailFormatOf.validate_email_format(email, message: "Email does not appear to be valid"))
    errors[:email] << "This email has already been taken" if User.exists_with_email?(email)

    errors[:password] << "Password cannot be left blank" if password.blank?
    errors[:password] << "Password must be more than 8 characters" if password.size <= 8

    errors[:confirm_password] << "Passwords do not match" if password != confirm_password

    if errors.values.all? { _1.empty? } # This is relativly secret so we don't want to give this out easily
      errors[:email] << "This email has already been taken" if User.exists_with_email?(email)
    end

    if errors.values.all? { _1.empty? }
      user = User.create(email:, password:)

      user.add_to_session(session)

      redirect_to dashboard_home_path
    else
      render Authentication::Views::Register.new(
        errors:,
        email: user_params[:email]
      )
    end
  end

  def user_params
    params.permit(
      :email,
      :password,
      :confirm_password
    )
  end
end
