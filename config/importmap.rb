def js(path) = Calagator::Engine.root.join("app/javascript").join(path)

pin "ical.js" # @2.0.1
pin "@event-calendar/core", to: "@event-calendar--core.js" # @3.4.0
pin "svelte", to: "https://ga.jspm.io/npm:svelte@4.2.18/src/runtime/index.js" # @4.2.18
pin "svelte/internal", to: "https://ga.jspm.io/npm:svelte@4.2.18/src/runtime/internal/index.js" # @4.2.18
pin "svelte/store", to: "https://ga.jspm.io/npm:svelte@4.2.18/src/runtime/store/index.js" # @4.2.18
pin "@event-calendar/list", to: "@event-calendar--list.js" # @3.4.0
pin "@event-calendar/day-grid", to: "@event-calendar--day-grid.js" # @3.4.0

pin_all_from js("calagator/calendar"), under: "calendar", to: "calagator/calendar"
