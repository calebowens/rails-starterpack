class ApplicationLayout < Phlex::HTML
  include Phlex::Rails::Layout
  include Phlex::Rails::Helpers::Flash

  def template(&block)
    doctype

    html do
      head do
        title { "You're awesome" }
        meta name: "viewport", content: "width=device-width,initial-scale=1"
        csp_meta_tag
        csrf_meta_tags
        stylesheet_link_tag "application", data_turbo_track: "reload"
        javascript_importmap_tags
      end

      body(&block)

      flashes = flash.map { [_1, _2] }

      div("x-data": "notificationController(#{flashes.to_json})", class: "notification-container", style: "pointer-events:none") do
        template_tag("x-for": "notice in notices", ":key": "notice.id") do
          div(
            "@click": "remove(notice.id)",
            "x-text": "notice.message",
            ":class": %({
              notice: notice.type == "notice",
              warning: notice.type == "warning",
              error: notice.type == "error"
            }),
            style: "pointer-events:all",
            class: "label"
          )
        end
      end
    end
  end
end
