class ApplicationController < ActionController::Base
  layout -> { ApplicationLayout }

  before_action :set_user

  class Replacer < ApplicationView
    def initialize(id, replacement)
      @id = id
      @replacement = replacement
    end

    def template
      turbo_stream.replace(@id) { render @replacement.call }
    end
  end

  def render_or_replace_id(page:, target_id:, replacement:)
    respond_to do |format|
      format.html { render page.call }
      format.turbo_stream { render Replacer.new(target_id, replacement), status: :unprocessable_entity, layout: nil }
    end
  end

  def set_user
    user = User.from_session(session)
    Current.user = user
  end

  def authenticate!
    set_user

    unless Current.user
      redirect_to root_path
    end
  end
end
