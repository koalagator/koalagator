# frozen_string_literal: true

require "calagator/engine"
require "calagator/version"

require "formtastic"
require "rails_autolink"
require "rails-observers"
require "nokogiri"
require "geokit"
require "htmlentities"
require "paper_trail"
require "ri_cal"
require "will_paginate"
require "will_paginate/array"
require "rest-client"
require "loofah"
require "loofah-activerecord"
require "acts-as-taggable-on"
require "jquery-rails"
require "jquery-ui-rails"
require "font-awesome-rails"
require "paper_trail_manager"
require "utf8-cleaner"
require "lucene_query"
require "rack/contrib/jsonp"
require "devise"
require "kramdown"

module Calagator
  mattr_accessor :title,
    :tagline,
    :url,
    :administrator_email,
    :admin_email,
    :admin_username,
    :admin_password,
    :admin_icon,
    :admin_resources,
    :open_registration,
    :user_resources,
    :search_engine,
    :icalendar_sequence_offset,
    :mapping_marker_color,
    :mapping_google_maps_api_key,
    :mapping_provider,
    :mapping_tiles,
    :venues_map_options,
    :denylist_patterns,
    :devise_enabled,
    :cache_enabled,
    :tag_cloud_min

  self.title = NAME
  self.tagline = "A Tech Calendar"
  self.url = "http://my-calagator.org/"
  self.administrator_email = "your@email.addr"
  self.open_registration = true
  self.search_engine = :sql
  self.icalendar_sequence_offset = 0
  self.mapping_marker_color = "green"
  self.mapping_provider = "stamen"
  self.mapping_tiles = "terrain"
  self.venues_map_options = {}
  self.denylist_patterns = [
    /\b(online|overseas).+(drugstore|pharmacy)\b/,
    /\bcialis\b/
  ]
  self.devise_enabled = false
  self.cache_enabled = true
  self.tag_cloud_min = 10

  def self.configure_search_engine
    kind = search_engine.try(:to_sym)

    Calagator::Event::SearchEngine.use(kind)
    Calagator::Venue::SearchEngine.use(kind)
  end

  def self.setup
    yield self
  end
end
