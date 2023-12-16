class Dashboard::Actions::HomeController < ApplicationController
  class View < ApplicationView
    def template
      h1(class: "foobar") { "Hello world!" }
    end
  end

  def handle
    render View
  end
end
