# frozen_string_literal: true

# == Schema Information
#
# Table name: venues
#
#  id              :integer          not null, primary key
#  access_notes    :text
#  address         :string
#  closed          :boolean          default(FALSE)
#  country         :string
#  created_by_name :string
#  description     :text
#  email           :string
#  events_count    :integer
#  latitude        :decimal(7, 4)
#  locality        :string
#  longitude       :decimal(7, 4)
#  pinned          :boolean          default(FALSE), not null
#  postal_code     :string
#  region          :string
#  street_address  :string
#  telephone       :string
#  title           :string
#  url             :string
#  wifi            :boolean          default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#  created_by_id   :integer
#  duplicate_of_id :integer
#  source_id       :integer
#
# Indexes
#
#  index_venues_on_created_by_id  (created_by_id)
#
# Foreign Keys
#
#  created_by_id  (created_by_id => calagator_users.id)
#
require "calagator/decode_html_entities_hack"
require "calagator/strip_whitespace"
require "calagator/url_prefixer"
require "paper_trail"
require "loofah-activerecord"
require "loofah/activerecord/xss_foliate"
require "validate_url"
require "active_model/serializers/xml"

module Calagator
  class Venue < Calagator::ApplicationRecord
    self.table_name = "venues"

    include StripWhitespace

    has_paper_trail
    acts_as_taggable_on :tags

    xss_foliate sanitize: %i[description access_notes]
    include DecodeHtmlEntitiesHack
    include ActiveModel::Serializers::Xml

    # Associations
    has_many :events, -> { non_duplicates }, dependent: :nullify
    belongs_to :created_by, class_name: "Calagator::User", optional: true
    belongs_to :source, optional: true

    # Triggers
    strip_whitespace! :title, :description, :address, :url, :street_address, :locality, :region, :postal_code, :country, :email, :telephone
    before_save :geocode!
    before_save :set_created_by_name, if: :created_by_id?

    # Validations
    validates :title, presence: true
    validates :url, url: {allow_blank: true}
    validates :latitude, inclusion: {in: -90..90, allow_nil: true}
    validates :longitude, inclusion: {in: -180..180, allow_nil: true}
    validates :title, :description, :address, :url, :street_address, :locality, :region, :postal_code, :country, :email, :telephone, denylist: true

    # Duplicates
    include DuplicateChecking
    duplicate_checking_ignores_attributes :source_id, :version, :closed, :wifi, :access_notes, :tag_list
    duplicate_squashing_ignores_associations :tags, :base_tags, :taggings
    duplicate_finding_scope -> { non_duplicates.order(:title, :id) }

    # Named scopes
    scope :primaries, -> { non_duplicates.includes(:source, :events, :tags, :taggings) }
    scope :with_public_wifi, -> { where(wifi: true) }
    scope :in_business, -> { where(closed: false) }
    scope :out_of_business, -> { where(closed: true) }
    scope :pinned, ->(pinned = true) { where(pinned: pinned) }

    def self.search(query, opts = {})
      SearchEngine.search(query, opts)
    end

    def url=(value)
      super UrlPrefixer.prefix(value)
    end

    # Display a single line address.
    def full_address
      full_address = "#{street_address}, #{locality} #{region} #{postal_code} #{country}"
      full_address.strip != "," && full_address
    end

    # Get an address we can use for geocoding
    def geocode_address
      full_address || address
    end

    # Return this venue's latitude/longitude location,
    # or nil if it doesn't have one.
    def location
      location = [latitude, longitude]
      location.all?(&:present?) && location
    end

    attr_accessor :force_geocoding

    def geocode!
      Geocoder.geocode(self)
      true # Try to geocode, but don't complain if we can't.
    end

    def update_events_count!
      update_attribute(:events_count, events.non_duplicates.count)
    end

    def set_created_by_name
      self.created_by_name = created_by.name_with_email
    end
    private :set_created_by_name
  end
end
