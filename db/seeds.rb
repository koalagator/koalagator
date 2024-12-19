# frozen_string_literal: true

begin
  require "faker"
  require "factory_bot_rails"
rescue LoadError
  puts "Calagator's seeds require faker and factory_bot_rails."
  puts "Add them to your gemfile and try again."
  exit 1
end

TAGS = [
  "gardening",
  "birdwatching",
  "camping",
  "hiking",
  "nature",
  "public lecture",
  "book launch"
].freeze

def random_tags
  TAGS.sample(rand(2..4)).join(", ")
end

FactoryBot.define do
  factory :seed_venue, class: Calagator::Venue do
    title { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    address do
      "#{Faker::Address.street_address},
                       #{Faker::Address.city},
                       #{Faker::Address.state}
                       #{Faker::Address.zip_code}"
    end
    street_address { Faker::Address.street_address }
    locality { Faker::Address.city }
    region { Faker::Address.state }
    postal_code { [Faker::Address.zip_code, Faker::Address.postcode].sample }
    country { Faker::Address.country }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    email { Faker::Internet.email }
    telephone { Faker::PhoneNumber.phone_number }
    url { Faker::Internet.url }
    closed { [false, true].sample }
    wifi { [true, false].sample }
    access_notes { Faker::Lorem.paragraph }

    trait :with_events do
      after(:create) do |seed_venue|
        create_list(:seed_event, 3, venue_id: seed_venue.id)
      end
    end
  end

  factory :seed_event, class: Calagator::Event do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    start_time do
      [
        Faker::Time.between(from: 2.years.ago, to: 2.years.from_now),
        Faker::Time.backward(days: 1),
        Faker::Time.forward(days: 1),
        Faker::Time.forward(days: 7)
      ].sample
    end
    created_at { start_time - 1.day }
    end_time { start_time + 3.hours }

    tag_list { random_tags }

    trait :with_venue do
      before(:create) do |seed_event|
        venue = create(:seed_venue)
        seed_event.venue_id = venue.id
      end
    end
  end
end

Calagator::Curation.create(
  description: "events related to being around the home",
  display_name: "at home",
  name: "at_home",
  priority: 0,
  block_list: "",
  require_list: "gardening, nature",
  deny_list: "",
  allow_list: ""
)

Calagator::Curation.create(
  description: "events related to being outdoors",
  display_name: "outdoors",
  name: "outdoors",
  priority: 1,
  block_list: "",
  require_list: "birdwatching, hiking, camping, nature",
  deny_list: "",
  allow_list: ""
)

Calagator::Curation.create(
  description: "events related to civic engagement",
  display_name: "civic engagement",
  name: "civic_engagement",
  priority: 2,
  block_list: "",
  require_list: "public lecture, book launch",
  deny_list: "",
  allow_list: ""
)

puts "Seeding database with sample data..."
FactoryBot.create_list(:seed_venue, 25, :with_events)
FactoryBot.create_list(:seed_venue, 25)
FactoryBot.create_list(:seed_event, 25, :with_venue)
FactoryBot.create_list(:seed_event, 25)
