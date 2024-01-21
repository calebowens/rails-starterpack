class Authentication::Actions::RegisterSubmitController < ApplicationController
  def handle
    submission = Submission.new(user_params.to_h)

    submission.ensures_present :email
    submission.ensures_valid_email :email

    submission.ensures_present :password
    submission.ensure(:password, message: "Password must be more than 8 character") { _1.size > 8 }

    submission.ensure(:confirm_password, message: "Passwords do not match") { _1 == submission[:password] }

    if submission.valid?
      submission.ensure(:email, message: "The email has already been taken") { !User.exists_with_email?(_1) }
    end

    if submission.valid?
      user = User.create(email: submission[:email], password: submission[:password])

      user.add_to_session session

      redirect_to dashboard_home_path, status: :see_other
    else
      render_or_replace_id(
        page: -> { Authentication::Views::Register.new(submission:) },
        target_id: "register",
        replacement: -> { Authentication::Components::RegisterForm.new(submission:) }
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
