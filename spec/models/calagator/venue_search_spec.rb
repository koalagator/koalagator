# frozen_string_literal: true

require "spec_helper"

module Calagator
  describe Venue, type: :model do
    shared_examples_for "#search" do
      it "returns everything when searching by empty string" do
        venue1 = create(:venue)
        venue2 = create(:venue)
        expect(described_class.search("")).to match_array([venue1, venue2])
      end

      it "searches venue titles by substring" do
        create(:venue, title: "wtfbbq")
        venue2 = create(:venue, title: "zomg!")
        expect(described_class.search("zomg")).to eq([venue2])
      end

      it "searches venue descriptions by substring" do
        create(:venue, description: "wtfbbq")
        venue2 = create(:venue, description: "zomg!")
        expect(described_class.search("zomg")).to eq([venue2])
      end

      it "searches venue tags by exact match" do
        create(:venue, tag_list: %w[wtf bbq zomg])
        venue2 = create(:venue, tag_list: %w[wtf bbq omg])
        expect(described_class.search("omg")).to eq([venue2])
      end

      it "searches case-insensitively" do
        create(:venue, title: "WTFBBQ")
        venue2 = create(:venue, title: "ZOMG!")
        expect(described_class.search("zomg")).to eq([venue2])
      end

      it "sorts by title" do
        venue2 = create(:venue, title: "zomg")
        venue1 = create(:venue, title: "omg")
        expect(described_class.search("", order: "name")).to eq([venue1, venue2])
      end

      it "can limit to venues with wifi" do
        create(:venue, wifi: false)
        venue2 = create(:venue, wifi: true)
        expect(described_class.search("", wifi: true)).to eq([venue2])
      end

      it "excludes closed venues" do
        create(:venue, closed: true)
        venue2 = create(:venue, closed: false)
        expect(described_class.search("")).to eq([venue2])
      end

      it "can include closed venues" do
        venue1 = create(:venue, closed: true)
        venue2 = create(:venue, closed: false)
        expect(described_class.search("", include_closed: true)).to match_array([venue1, venue2])
      end

      it "can limit number of venues" do
        create_list(:venue, 2)
        expect(described_class.search("", limit: 1).count).to eq(1)
      end

      it "does not search multiple terms" do
        create(:venue, title: "zomg")
        create(:venue, title: "omg")
        expect(described_class.search("zomg omg")).to eq([])
      end

      it "ANDs terms together to narrow search results" do
        venue2 = create(:venue, title: "zomg omg")
        create(:venue, title: "zomg cats")
        expect(described_class.search("zomg omg")).to eq([venue2])
      end
    end

    describe "Sql" do
      around do |example|
        original = Venue::SearchEngine.kind
        Venue::SearchEngine.kind = :sql
        example.run
        Venue::SearchEngine.kind = original
      end

      it_behaves_like "#search"

      it "is using the sql search engine" do
        expect(Venue::SearchEngine.kind).to eq(:sql)
      end
    end
  end
end
