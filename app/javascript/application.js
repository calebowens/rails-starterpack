// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import Alpine from "alpinejs"
import * as Routes from "routes"

Alpine.data("notificationController", (initialNotices = []) => ({
    notices: [],
    init() {
        initialNotices.forEach(([type, message]) => {
            this.add(type, message)
        })

        this.$el.addEventListener("notify", ((event) => {
            this.add(event.details.type, event.details.message)
        }).bind(this))
    },

    add(type, message) {
        this.notices.push({
            id: crypto.randomUUID(),
            type: this.sanitizeType(type),
            message: message
        })
    },

    remove(id) {
        const noticeIndex = this.notices.findIndex((notices) => notices.id == id)
        this.notices.splice(noticeIndex, 1)
    },

    sanitizeType(type) {
        if (["notice", "warning", "error"].includes(type)) {
            return type
        } else {
            return "notice"
        }
    }
}))


window.Routes = Routes
window.Alpine = Alpine

Alpine.start()
