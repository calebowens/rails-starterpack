class Authentication::Actions::LoginSubmitController < ApplicationController
  def handle
    errors = {email: [], password: []}

    email = user_params[:email] || ""
    password = user_params[:password] || ""

    errors[:email] << "Email cannot be left blank" if email.blank?
    errors[:password] << "Password cannot be left blank" if password.blank?

    user = User.from_login_details(email:, password:)

    errors[:email] << "The email and password provided did not match our records" if user.nil?

    if errors.values.all? { _1.empty? }
      user.add_to_session(session)

      redirect_to dashboard_home_path, status: :see_other
    else
      render Authentication::Views::Login.new(
        errors:,
        email: user_params[:email]
      )
    end
  end

  def user_params
    params.permit(
      :email,
      :password
    )
  end
end
