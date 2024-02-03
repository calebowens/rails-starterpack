# README

## Production Readyness

There are two goals for this project
1. To try and build a starting point which I can use to put together a project in a very short amount of time.
2. To try and answer some of the "what ifs" that I end up thinking about at my day job, but would be wholly
   inapropriate to implement in a work setting due to their "unrailsy" nature

While this is a project that I'm using in apps that I hope will serve real customers, and I'm putting a reasonable
effort into mantaining this. Given the fact that there are experiemental code structure choises and dev builds
importmaps, caution is advised!

## Development environment setup

### Pre-Commit Hooks

Everyone should have pre-commit hooks setup!

1. Run `./install_git_hooks.sh`

3. Voila!

## Structure

- app
  - features <- Idea behind this is that we focus more on feature based groupings, rather than categorising code. Part
    of the idea is that it will make each feature its own isolated application, with some shared common utilities
    - pages
    - authentication
    - dashbaord
  - common
    - components <- contains shared phlex components

## Chosen stack

- View
  - [Phlex](https://phlex.fun) templating
- JS and CSS
  - Served via [Propshaft](https://github.com/rails/propshaft)
  - JS
    - Imports "managed" with [importmaps-rails](https://github.com/rails/importmap-rails)
      - Importantly, we're using v1 of importmaps as there are a handful of issues in v2 as it moves to a vendor only approach
    - [AlpineJS](https://alpinejs.dev) over Stimulus
    - Routing with railsware's [js-routes](https://github.com/railsware/js-routes)
    - [@rails/request.js](https://github.com/rails/request.js) fetch wrapper
  - CSS
    - [dartsass-rails](https://github.com/rails/dartsass-rails) for SCSS
      - Nesting is becoming available in all the major browsers in pure CSS, so I could be convinced to drop dartsass at
        some point.
    - Custom starter styles with a "prefer margin on bottom" approach and custom utility classes.
- Forms
  - Forms are done with form_with
  - Subjects of forms should be custom ActiveModel::Model's which handles all validations. The subject of a form should
    never be a Database model
- Hosting
  - Custom development and production docker compose setup
- Testing
  - Minitest with rails's active support extensions [see](https://guides.rubyonrails.org/testing.html)
  - [Capybara](https://github.com/teamcapybara/capybara) with [Cuprite](https://github.com/rubycdp/cuprite) for system testing
  - Database records inside tests should be as they would be in the app, without factorybot or fixtures.
- Formatting
  - [Standard RB](https://github.com/standardrb/standard) and [Standard Rails](https://github.com/standardrb/standard-rails)
- Mail chatching
  - [Mailhog](https://github.com/mailhog/MailHog)
- Jobs
  - Handled via [Good Job](https://github.com/bensheldon/good_job)
    - May shift over to [Solid Queue](https://github.com/basecamp/solid_queue) depending on how its feature set evolves
- Authentication
  - Using a bispoque authentication system based on "has_secure_passsword" which should be simple to build upon with
    omniauth, or replace with another authentication system.
- Caching
  - [Solid Cache](https://github.com/rails/solid_cache)
- N+1 catching via [Bullet](https://github.com/flyerhzm/bullet)

## Style

### AlpineJS in Phlex markup

Prefer `"x-ref": "foo"` over `x_ref: "foo"` or `"x-ref" => "foo"`

### Routes

Prefer `get <path>, to: <controller>` style of routes as it allows for a more consistent hash style when paired with
standardrb

### Function calls

When we have a function whose value is not used, IE:
```rb
cats.push "tabby"
puts "foobar"
```
we call it without parans, unless passing a block using curly braces, IE:
```rb
submission.ensure(:password, message: "Password must be more than 8 character") { _1.size <= 8 }
```

When we use the return of the function, IE:
```rb
p make_number("123") + 123
asdf = make_number("321")
```
we call it with parans


## Thoughts and plans

## Example Controller
```rb
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
```
