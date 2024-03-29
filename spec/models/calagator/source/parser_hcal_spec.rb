# frozen_string_literal: true

require "spec_helper"

module Calagator
  describe Source::Parser::Hcal, "with hCalendar events", type: :model do
    it "parses hcal" do
      url = "http://mysample.hcal/"
      stub_request(:get, url).to_return(body: read_sample("hcal_single.xml"))
      hcal_source = Source.new(title: "Calendar event feed", url: url)

      events = hcal_source.to_events

      expect(events.size).to eq 1
      {
        title: "Calendar event",
        description: "Check it out!",
        start_time: Time.parse("2008-1-19").in_time_zone,
        end_time: Time.parse("2008-1-20").in_time_zone,
        url: "http://www.cubespacepdx.com",
        venue_id: nil # TODO: what should venue instance be?
      }.each do |key, value|
        expect(events.first.send(key)).to eq value
      end
    end

    it "strips html from the venue title" do
      url = "http://mysample.hcal/"
      stub_request(:get, url).to_return(body: read_sample("hcal_upcoming_v1.html"))
      hcal_source = Source.new(title: "Calendar event feed", url: url)

      events = hcal_source.to_events

      expect(events.first.venue.title).to eq "Jive Software Office"
    end

    it "parses a page with multiple events" do
      url = "http://mysample.hcal/"
      stub_request(:get, url).to_return(body: read_sample("hcal_multiple.xml"))
      hcal_source = Source.new(title: "Calendar event feed", url: url)

      events = hcal_source.to_events
      expect(events.size).to eq 2
      first, second = *events
      expect(first.start_time).to eq Time.parse("2008-1-19").in_time_zone
      expect(first.end_time).to eq Time.parse("2008-01-20").in_time_zone
      expect(second.start_time).to eq Time.parse("2008-2-2").in_time_zone
      expect(second.end_time).to eq Time.parse("2008-02-03").in_time_zone
    end
  end

  describe Source::Parser::Hcal, "with hCalendar to Venue parsing", type: :model do
    it "extracts an Venue from an hCalendar text" do
      url = "http://mysample.hcal/"
      stub_request(:get, url).to_return(body: read_sample("hcal_upcoming_v1.html"))

      events = described_class.to_events(url: url)
      event = events.first
      venue = event.venue

      expect(venue).to be_a_kind_of(Venue)
      expect(venue.locality).to eq "portland"
      expect(venue.street_address).to eq "317 SW Alder St Ste 500"
      expect(venue.latitude).to be_within(0.1).of(45.5191)
      expect(venue.longitude).to be_within(0.1).of(-122.675)
      expect(venue.postal_code).to eq "97204"
    end
  end
end
