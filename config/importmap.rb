# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "routes", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@rails/request.js", to: "@rails--request.js/src/index.js" # @0.0.9
pin "alpinejs", to: "alpinejs/dist/module.esm.js" # @3.13.5
