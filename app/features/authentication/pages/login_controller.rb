class Authentication::Pages::LoginController < ApplicationController
  class ViewContext < ActiveSupport::CurrentAttributes
    attribute :form_object
  end

  class FormObject
    include ActiveModel::Model
    include HasErrors

    attr_accessor :email, :password

    validates_presence_of :email
    validates_presence_of :password

    validate :ensure_user_exists # Must run last for security

    def user
      @user ||= User.from_login_details(email:, password:)
    end

    def ensure_user_exists
      return unless errors.blank?

      if user.nil?
        errors.add :email, :no_user, message: "and password provided did not match our records"
      end
    end
  end

  class View < ApplicationView
    def template
      h1 { "Login" }

      render Form
    end
  end

  class Form < ApplicationView
    def template
      form_with(model: ViewContext.form_object, url: authentication_login_path, id: "login") do |f|
        f.label :email, "Email"
        f.text_field :email
        render ViewContext.form_object.errors_for(:email)

        f.label :password, "Password"
        f.password_field :password
        render ViewContext.form_object.errors_for(:password)

        f.submit "Login"
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
      ViewContext.form_object.user.add_to_session(session)

      redirect_to dashboard_home_path, status: :see_other
    else
      render_or_replace_id(
        page: -> { View.new },
        target_id: "login",
        replacement: -> { Form.new }
      )
    end
  end

  def user_params
    params.require(:authentication_pages_login_controller_form_object).permit(
      :email,
      :password
    )
  end
end
