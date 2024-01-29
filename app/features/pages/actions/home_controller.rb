class Pages::Actions::HomeController < ApplicationController
  class View < ApplicationView
    def template
      render Components::Header.new

      h1 { "Welcome home!" }

      button(id: "tippy") { "tippy button" }
    end
  end

  def handle
    render View
  end
end
