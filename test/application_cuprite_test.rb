require "test_helper"
require "phlex/rails"
require "phlex/testing/rails/view_helper"
require "capybara/cuprite"

class ApplicationCupriteTest < ActionDispatch::SystemTestCase
  def self.include_phlex_helpers
    include Phlex::Testing::Rails::ViewHelper
    include Phlex::Testing::Capybara::ViewHelper
  end

  driven_by :cuprite, screen_size: [1920, 1080], options: {browser_options: {"no-sandbox" => nil}}
end
