class Authentication::Pages::LogoutController < ApplicationController
  def handle
    Current.user&.remove_from_session(session)

    redirect_back_or_to root_path
  end
end
