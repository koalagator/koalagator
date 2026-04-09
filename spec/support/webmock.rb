# frozen_string_literal: true

require "webmock/rspec"

RSpec.configure do |config|
  config.before(:suite) do
    WebMock.disable_net_connect!(
      allow_localhost: true, # poltergeist needs to connect to localhost
      allow: "github.com" # webdrivers needs to download geckodriver
    )
  end
end
