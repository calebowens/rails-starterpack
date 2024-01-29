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
        link(rel: "stylesheet", href: "https://fonts.googleapis.com/css2?family=Libre+Franklin:wght@400&family=Merriweather:wght@400;700&family=Roboto+Mono&display=swap")
        stylesheet_link_tag "application", data_turbo_track: "reload"
        script { "window.process = { get env() { console.warn(\"Nodeism process.env has been used; You should not rely on nodeisms to being in the browser. If process.env is being used by a 3rd party dependency, consider submitting an issue to the maintainer\"); return \"production\" } }".html_safe }
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
