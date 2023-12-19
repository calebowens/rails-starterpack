Rails.application.routes.draw do
  mount GoodJob::Engine => "good_job"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  root "pages/actions/home#handle"

  namespace :dashboard do
    scope module: :actions do
      get "home" => "home#handle"
    end
  end

  namespace :authentication do
    scope module: :actions do
      get "/register" => "register#handle"
      post "/register" => "register_submit#handle"
      get "/login" => "login#handle"
      post "/login" => "login_submit#handle"
      delete "/logout" => "logout#handle"
    end
  end
end
