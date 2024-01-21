# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "routes", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "alpinejs", to: "https://ga.jspm.io/npm:alpinejs@3.13.3/dist/module.esm.js"
pin "@rails/request.js", to: "https://ga.jspm.io/npm:@rails/request.js@0.0.9/src/index.js"
