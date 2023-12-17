class Authentication::Actions::LoginController < ApplicationController
  def handle
    redirect_to root_path if Current.user

    render Authentication::Views::Login
  end
end
