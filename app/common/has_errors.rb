module HasErrors
  extend ActiveSupport::Concern

  class Errors < ApplicationComponent
    def initialize(messages:)
      @messages = messages
    end

    def template
      div(class: "submission-errors") do
        @messages.each do |message|
          p { message }
        end
      end
    end
  end

  def errors_for(attribute)
    Errors.new(messages: errors.full_messages_for(attribute))
  end
end
