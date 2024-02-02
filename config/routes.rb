Rails.application.routes.draw do
  mount GoodJob::Engine => "good_job"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up", to: "rails/health#show", as: :rails_health_check

  root "pages/actions/home#handle"

  namespace :dashboard do
    scope module: :actions do
      get "home", to: "home#handle"
    end
  end

  namespace :authentication do
    scope module: :pages do
      get "/login", to: "login#view"
      post "/login", to: "login#submit"

      get "/register", to: "register#view"
      post "/register", to: "register#submit"
      delete "/logout", to: "logout#handle"
    end
  end
end
