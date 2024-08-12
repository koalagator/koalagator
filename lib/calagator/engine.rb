# frozen_string_literal: true

require "rack/contrib/jsonp"
require "sprockets/railtie"
require "importmap-rails"

module Calagator
  class Engine < ::Rails::Engine
    isolate_namespace Calagator

    config.middleware.use Rack::JSONP

    # https://stackoverflow.com/questions/69635552/how-to-set-up-importmap-rails-in-rails-7-engine
    initializer "calagator.importmap", before: "importmap" do |app|
      app.config.assets.paths << root.join("app/javascript")
      app.config.assets.paths << root.join("vendor/javascript")

      app.config.importmap.paths << root.join("config/importmap.rb")
      app.config.importmap.cache_sweepers +=
        ["vendor/javascript", "app/javascript"].map { |str| root.join(str) }
    end

    config.assets.precompile += %w[
      *.png
      *.gif
      calagator/errors.css
      leaflet.js
      leaflet_google_layer.js
      site-icon.png
      spinner.gif
      tag_icons/*
      leaflet
    ]

    config.to_prepare do
      # Include custom helpers from parent app
      Calagator::ApplicationController.helper Rails.application.helpers
    end

    config.after_initialize do
      Calagator.configure_search_engine
    end
  end
end
