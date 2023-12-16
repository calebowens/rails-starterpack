class Dashboard::Actions::HomeController < ApplicationController
  class View < ApplicationView
    def template
      h1(class: "foobar") { "Hello world!" }
      render Components::Modal.new do |modal|
        modal.open_button { "Open me!" }
        modal.body do
          p { "Hi! I'm a modal" }
        end
      end
    end
  end

  def handle
    render View
  end
end
