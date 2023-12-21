require "test_helper"
require "phlex/rails"
require "phlex/testing/rails/view_helper"

class ApplicationSeleniumTest < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end
