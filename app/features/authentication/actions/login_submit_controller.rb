class Authentication::Actions::LoginSubmitController < ApplicationController
  def handle
    submission = Submission.new(user_params.to_h)

    submission.ensures_present :email
    submission.ensures_present :password

    user = User.from_login_details(email: submission[:email], password: submission[:password])

    submission.ensure(:email, message: "The email and password provided did not match our records") { user.present? }

    if submission.valid?
      user.add_to_session(session)

      redirect_to dashboard_home_path, status: :see_other
    else
      render_or_replace_id(
        page: -> { Authentication::Views::Login.new(submission:) },
        target_id: "login",
        replacement: -> { Authentication::Components::LoginForm.new(submission:) }
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
