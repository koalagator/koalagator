# frozen_string_literal: true

require "rack/contrib/jsonp"
require "sprockets/railtie"

module Calagator
  class Engine < ::Rails::Engine
    isolate_namespace Calagator

    config.middleware.use Rack::JSONP

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
