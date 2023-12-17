class Dashboard::Actions::HomeController < ApplicationController
  class View < ApplicationView
    def template
      render Components::Header.new

      h1(class: "foobar") { "Hello world!" }

      if Current.user
        p { "Hello #{Current.user.email}" }
      end

      render Components::Modal.new do |modal|
        modal.open_button { "Open me!" }
        modal.body do
          p { "Hi! I'm a modal" }
        end
      end
    end
  end

  before_action :authenticate!

  def handle
    render View
  end
end
