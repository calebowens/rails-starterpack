# README

## Chosen stack

- View
  - [x] Phlex
- Js
  - Rails powered Importmaps <- we can always move away from the rails side later and maintain the same functionality
  - AplineJS over stimulus <- Most components can be implemented without
  - @rails/request.js <- Handles CSRF for us
  - Turbo <- This was chosen over XHTML as it integrates with rails better. I'm not going to use this heavily or at
    all really.
  - JS Routes <- https://github.com/railsware/js-routes
- CSS
  - [x] dartcss-rails <- This lets us keep using the default asset pipeline with sass. I like sass. I also want to
        avoid using comment imports like the plauge
    - I will need to use @use rather than @import
  - Implement a subset of tailwind CSS padding and margin classes
- Forms
  - To use form_with over form_for or simple_form_for. <- I want to move away from the model centric view that
    simple_form focuses on.
- Docker
  - [x] Set up with docker compose
- Hosting
  - Stick with Heroku
  - Do someting fancy with docker compose in production on a VPS
  - Look at AWS Fargate https://explore.skillbuilder.aws/learn/course/external/view/elearning/81/introduction-to-aws-fargate
- Testing
  - Minitest
  - Capybara
    - Selenium
- Formatting
  - [x] Standard RB
- Mail chatching
  - Mailhog
- Jobs
  - Good Job <- This means we don't need to have a redis database, and avoids problems with redis loosing all its data
      when restarting
- Authentication
  - has_secure_password
  - User.authenticated_by(email: 'asdfasdf', password: 'asdfasdf')
