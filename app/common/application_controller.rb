class ApplicationController < ActionController::Base
  layout -> { ApplicationLayout }

  before_action :set_user

  def set_user
    user = User.from_session(session)
    Current.user = user
  end

  def authenticate!
    set_user

    unless Current.user
      redirect_to root_path
    end
  end
end
