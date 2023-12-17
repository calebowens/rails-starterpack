class Authentication::Actions::RegisterController < ApplicationController
  def handle
    redirect_to root_path if Current.user

    render Authentication::Views::Register
  end
end
