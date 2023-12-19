# README

## Goals

- Be as standard as possible when using gems.
- Avoid structuring the database around our features.

Arguably, these are two very contradictory goals. With the way that I'm strucutring my controllers, its counter to how
most if not all rails projects work.

I think the way that I'm reconsiling this, is that, for eample I'm still using regular rails controllers and using phlex
in a standard way. Such that, I'm not having ask rails to bend over backwards to find the files.

For example, I'm still able to define rails routes without needing any fancy and breakble helper methods that make
assumptions about the internals of rails routing.

## Structure

- app
  - features <- Idea behind this is that we focus more on feature based groupings, rather than categorising code. Part
    of the idea is that it will make each feature its own isolated application, with some shared common libraries
    - pages
    - authentication
    - dashbaord
  - common
    - components <- contains shared phlex components

## Chosen stack

- View
  - [x] Phlex
- Js
  - Rails powered Importmaps <- we can always move away from the rails side later and maintain the same functionality
  - [x] AplineJS over stimulus <- Most components can be implemented without
  - [x] @rails/request.js <- Handles CSRF for us
  - [x] Turbo <- This was chosen over XHTML as it integrates with rails better. I'm not going to use this heavily or at
    all really.
  - [x] JS Routes <- https://github.com/railsware/js-routes
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
- [x] Authentication
  - has_secure_password
  - User.authenticated_by(email: 'asdfasdf', password: 'asdfasdf')
- Caching
  - [x] Solid Cache
