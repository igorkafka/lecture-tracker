# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "events", preload: true
pin "jquery", to: "https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bulma-calendar", to: "https://ga.jspm.io/npm:bulma-calendar@6.1.19/dist/js/bulma-calendar.js"
