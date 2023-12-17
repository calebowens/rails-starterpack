class HelloWorldJob < ApplicationJob
  def perform
    Rails.logger.info("Hello world")
  end
end
