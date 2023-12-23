class ApplicationView < Phlex::HTML
  include Phlex::Rails::Helpers::Routes

  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::FormWith
  include Phlex::Rails::Helpers::TurboStream
  include Phlex::Rails::Helpers::TurboFrameTag
end
