class Authentication::Pages::RegisterController < ApplicationController
  class ViewContext < ActiveSupport::CurrentAttributes
    attribute :form_object
  end

  class FormObject
    include ActiveModel::Model
    include HasErrors

    attr_accessor :email, :password, :confirm_password

    validates :email, presence: true, email_format: {message: "formatted incorrectly"}
    validates :password, presence: true, length: {minimum: 8, maximum: 64}
    validates :confirm_password, presence: true
    validate :ensure_confirm_password_equals_password

    validate :ensure_no_user_with_details # Must run last for security

    def ensure_no_user_with_details
      return unless errors.blank?

      if User.exists_with_email?(email)
        errors.add :email, :email_used, message: "is already taken"
      end
    end

    def ensure_confirm_password_equals_password
      if confirm_password != password
        errors.add :confirm_password, :not_password, message: "must match password"
      end
    end
  end

  class View < ApplicationView
    def template
      h1 { "Create a user" }

      render Form
    end
  end

  class Form < ApplicationView
    def template
      form_with(model: ViewContext.form_object, url: authentication_register_path, id: "register") do |f|
        f.label :email, "Email"
        f.text_field :email
        render ViewContext.form_object.errors_for(:email)

        f.label :password, "Password"
        f.password_field :password
        render ViewContext.form_object.errors_for(:password)

        f.label :confirm_password, "Confirm Password"
        f.password_field :confirm_password
        render ViewContext.form_object.errors_for(:confirm_password)

        f.submit "Register"
      end
    end
  end

  def view
    redirect_to root_path if Current.user

    ViewContext.form_object = FormObject.new

    render View
  end

  def submit
    ViewContext.form_object = FormObject.new(user_params)

    if ViewContext.form_object.valid?
      user = User.create!(email: ViewContext.form_object.password, password: ViewContext.form_object.password)

      user.add_to_session session

      redirect_to dashboard_home_path, status: :see_other
    else
      render_or_replace_id(
        page: -> { View.new },
        target_id: "register",
        replacement: -> { Form.new }
      )
    end
  end

  def user_params
    params.require(:authentication_pages_register_controller_form_object).permit(
      :email,
      :password,
      :confirm_password
    )
  end
end
