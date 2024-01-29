class Authentication::Pages::RegisterController < ApplicationController
  class ViewContext < ActiveSupport::CurrentAttributes
    attribute :form_object
  end

  class FormObject
    include ActiveModel::Model
    include HasErrors

    attr_accessor :email, :password, :confirm_password

    validates :email, presence: true
    validates :password, presence: true, length: {minimum: 8, maximum: 64}
    validates :confirm_password, presence: true, comparison: {equal_to: -> { password }}
  end

  class View
    def template
      h1 { "Create a user" }

      render Form
    end
  end

  class Form
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

  def view
    redirect_to root_path if Current.user

    ViewContext.form_object = FormObject.new

    render View
  end

  def submit
    ViewContext.form_object = FormObject.new(user_params)

    if ViewContext.form_object.validations_passed?
    end

    if ViewContext.form_object.validations_passed?
      user = User.create!(email: submission[:email], password: submission[:password])

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
    params.permit(
      :email,
      :password,
      :confirm_password
    )
  end
end
