class Components::Header < ApplicationView
  def template
    header do
      if Current.user
        link_to "Dashboard", dashboard_home_path
        link_to "Log out", authentication_logout_path, data: {turbo_method: :delete}
      else
        link_to "Login", authentication_login_path
        link_to "Register", authentication_register_path
      end
    end
  end
end
