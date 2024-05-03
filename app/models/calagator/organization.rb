# == Schema Information
#
# Table name: calagator_organizations
#
#  id               :integer          not null, primary key
#  description      :string
#  display_name     :string
#  name             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  primary_venue_id :integer
#
# Indexes
#
#  index_calagator_organizations_on_name              (name) UNIQUE
#  index_calagator_organizations_on_primary_venue_id  (primary_venue_id)
#
# Foreign Keys
#
#  primary_venue_id  (primary_venue_id => venues.id)
#
module Calagator
  class Organization < Calagator::ApplicationRecord
    include ActiveModel::Serializers::Xml

    has_many :organization_users
    has_many :admin_organization_users, -> { where(admin: true) }, foreign_key: :organization_id, class_name: "Calagator::OrganizationUser"
    has_many :users, through: :organization_users
    has_many :admin_users, through: :admin_organization_users, source: :user

    has_many :organization_events
    has_many :events, through: :organization_events

    has_many :organization_venues
    has_many :venues, through: :organization_venues

    belongs_to :primary_venue, class_name: "Calagator::Venue", optional: true

    validates :name, presence: true, format: {with: /\A[a-z0-9\-_]+\z/, message: "only allows ASCII letters, numbers, dashes and underscores"}

    def display_name
      attribute = read_attribute(:display_name)
      attribute.present? ? attribute : name
    end

    def user_is_admin?(user)
      return false unless user.is_a? User
      return true if user.admin?
      admin_users.where(id: user).any?
    end

    def to_param
      name
    end
  end
end
