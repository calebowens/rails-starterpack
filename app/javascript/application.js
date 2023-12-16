// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import Alpine from "alpinejs"
import * as Routes from "./routes.js"

window.Routes = Routes

window.Alpine = Alpine

Alpine.start()
