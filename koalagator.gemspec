# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "calagator/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  # Please configure these in 'lib/calagator/version.rb'
  s.name = Calagator::GEMSPEC
  s.version = Calagator::VERSION

  s.authors = ["the Koalagator team"]
  s.email = ["info@calagator.org"]
  s.homepage = "https://github.com/koalagator/koalagator"
  s.summary = "A calendar for communities"
  s.description = "#{Calagator::NAME} is an open source community calendaring platform"
  s.license = "AGPL-3.0-or-later"

  s.required_ruby_version = [">= 3.0.0"]

  s.files = Dir["{app,config,lib,vendor}/**/*"] + Dir["db/**/*.rb"] + ["LICENSE.md", "Rakefile", "README.md", "rails_template.rb"]
  s.executables << "koalagator"

  # To change this Rails requirement, update RAILS_VERSION in lib/calagator/version.rb
  s.add_dependency "rails", Calagator::RAILS_VERSION
  s.add_dependency "sprockets-rails", "~> 3.4"
  s.add_dependency "activemodel-serializers-xml", "~> 1.0"
  s.add_dependency "acts-as-taggable-on", "~> 10.0"
  s.add_dependency "annotate", ">= 3.1.1", "< 3.3.0"
  s.add_dependency "bluecloth", "~> 2.2"
  s.add_dependency "bootsnap", "~> 1.18.4"
  s.add_dependency "font-awesome-rails", "~> 4.7"
  s.add_dependency "formtastic", "~> 5.0"
  s.add_dependency "geokit", ">= 1.9", "< 1.14"
  s.add_dependency "htmlentities", "~> 4.3.4"
  s.add_dependency "jquery-rails", "~> 4.6"
  s.add_dependency "jquery-ui-rails", "~> 7.0"
  s.add_dependency "loofah", "~> 2.24.0"
  s.add_dependency "loofah-activerecord", ">= 1.2", "< 3.0"
  s.add_dependency "lucene_query", "0.1"
  s.add_dependency "microformats", "~> 4.5"
  s.add_dependency "nokogiri", "~> 1.18.7"
  s.add_dependency "paper_trail", "~> 15.1"
  s.add_dependency "rack-contrib", "~> 2.5.0"
  s.add_dependency "rails-observers", "~> 0.1.5"
  s.add_dependency "rails_autolink", "~> 1.1"
  s.add_dependency "recaptcha", "~> 5.8"
  s.add_dependency "rest-client", "~> 2.0"
  s.add_dependency "demingfactor-ri_cal", "~> 0.10.0"
  s.add_dependency "sassc-rails", "~> 2.1"
  s.add_dependency "standard", "~> 1.43.0"
  s.add_dependency "utf8-cleaner", ">= 0.0.6", "< 1.1.0"
  s.add_dependency "validate_url", "~> 1.0.15"
  s.add_dependency "will_paginate", "~> 3.0"
  # s.add_dependency "pg", "~> 1.5"
  s.add_dependency "sqlite3", "~> 2.5.0"
  # Fix deprecation warning with Zeitwerk
  s.add_dependency "observer", "~> 0.1"
  # s.add_dependency "listen", "~> 3.1.5"
  s.add_dependency "devise", "~> 4.9.4"
  s.add_dependency "importmap-rails", "~> 2.0"
  s.add_dependency "smarter_csv", "~> 1.13"
  s.add_dependency "csv", "~> 3.3.3"

  unless Calagator::MAJOR_RUBY_VERSION <= 2
    s.add_dependency "rexml", "~> 3.4.0" # moved outside ruby core from 3.0
  end

  s.add_development_dependency "appraisal", "~> 2.4"
  s.add_development_dependency "capybara", "~> 3.40"
  s.add_development_dependency "cuprite", "~> 0.15"
  s.add_development_dependency "database_cleaner", "~> 2.1.0"
  s.add_development_dependency "factory_bot_rails", "~> 6.4.4"
  s.add_development_dependency "faker", "~> 3.5.1"
  s.add_development_dependency "gem-release", "~> 2.2.4"
  s.add_development_dependency "puma", "~> 6.5.0"
  s.add_development_dependency "rspec-activemodel-mocks", "~> 1.2.1"
  s.add_development_dependency "rspec-collection_matchers", "~> 1.2.1"
  s.add_development_dependency "rspec-its", "~> 2.0.0"
  s.add_development_dependency "rspec-rails", "~> 7.1"
  s.add_development_dependency "simplecov", "~> 0.18"
  s.add_development_dependency "simplecov-lcov", "~> 0.8"
  s.add_development_dependency "timecop", "~> 0.9.5"
  s.add_development_dependency "uglifier", "~> 4.2.0"
  s.add_development_dependency "webmock", "~> 3.5"
  s.add_development_dependency "better_errors", "~> 2.10", ">= 2.10.1"
  s.add_development_dependency "binding_of_caller", "~> 1.0", ">= 1.0.1"
end
