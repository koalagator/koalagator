# frozen_string_literal: true

require "spec_helper"

module Calagator
  describe Event, type: :model do
    shared_examples_for "#search" do
      it "returns everything when searching by empty string" do
        event1 = create(:event)
        event2 = create(:event)
        expect(described_class.search("")).to match_array([event1, event2])
      end

      it "searches event titles by substring" do
        create(:event, title: "wtfbbq")
        event2 = create(:event, title: "zomg!")
        expect(described_class.search("zomg")).to eq([event2])
      end

      it "searches event descriptions by substring" do
        create(:event, description: "wtfbbq")
        event2 = create(:event, description: "zomg!")
        expect(described_class.search("zomg")).to eq([event2])
      end

      it "searches event tags by exact match" do
        create(:event, tag_list: %w[wtf bbq zomg])
        event2 = create(:event, tag_list: %w[wtf bbq omg])

        expect(described_class.search("omg")).to eq([event2])
      end

      it "does not search multiple terms" do
        create(:event, title: "wtf")
        create(:event, title: "zomg!")
        create(:event, title: "bbq")
        expect(described_class.search("wtf zomg")).to match_array([])
      end

      it "searches case-insensitively" do
        create(:event, title: "WTFBBQ")
        event2 = create(:event, title: "ZOMG!")
        expect(described_class.search("zomg")).to eq([event2])
      end

      it "sorts by start time descending" do
        event2 = create(:event, start_time: 1.day.ago)
        event1 = create(:event, start_time: 1.day.from_now.to_datetime)
        expect(described_class.search("")).to eq([event1, event2])
      end

      it "can sort by event title" do
        event2 = create(:event, title: "zomg")
        event1 = create(:event, title: "omg")
        expect(described_class.search("", order: "name")).to eq([event1, event2])
      end

      it "can sort by venue title" do
        event2 = create(:event, venue: create(:venue, title: "zomg"))
        event1 = create(:event, venue: create(:venue, title: "omg"))
        expect(described_class.search("", order: "venue")).to eq([event1, event2])
      end

      it "can sort by start date" do
        event2 = create(:event, start_time: 1.year.ago)
        event1 = create(:event, start_time: 1.year.from_now.to_datetime)
        expect(described_class.search("", order: "date")).to eq([event1, event2])
      end

      it "can limit to current and upcoming events" do
        create(:event, start_time: 1.year.ago, end_time: 1.year.ago + 1.hour)
        event2 = create(:event, start_time: 1.hour.ago, end_time: 1.hour.from_now.to_datetime)
        event3 = create(:event, start_time: 1.year.from_now.to_datetime, end_time: 1.year.from_now.to_datetime + 1.hour)
        expect(described_class.search("", skip_old: true)).to eq([event3, event2])
      end

      it "can limit number of events" do
        create_list(:event, 2)
        expect(described_class.search("", limit: 1).count).to eq(1)
      end

      it "limit applies to current and past queries separately" do
        create(:event, title: "omg", start_time: 1.year.ago)
        create(:event, title: "omg", start_time: 1.year.ago)
        create(:event, title: "omg", start_time: 1.year.from_now.to_datetime)
        create(:event, title: "omg", start_time: 1.year.from_now.to_datetime)
        expect(described_class.search("omg", limit: 1).to_a.size).to eq(2)
      end

      it "ANDs terms together to narrow search results" do
        event1 = create(:event, title: "women who hack")
        create(:event, title: "women who bike")
        create(:event, title: "omg")
        expect(described_class.search("women who hack")).to eq([event1])
      end
    end

    describe "Sql" do
      # spec_helper defaults all tests to sql

      it_behaves_like "#search"

      it "searches event urls by substring" do
        create(:event, url: "http://example.com/wtfbbq.html")
        event2 = create(:event, url: "http://example.com/zomg.html")
        expect(described_class.search("zomg")).to eq([event2])
      end

      it "is using the sql search engine" do
        expect(Event::SearchEngine.kind).to eq(:sql)
      end

      it "does not provide a score" do
        expect(Event::SearchEngine).not_to be_score
      end
    end
  end
end
