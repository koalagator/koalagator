# == Schema Information
#
# Table name: calagator_organization_venues
#
#  id              :integer          not null, primary key
#  admin           :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :integer          not null
#  venues_id       :integer          not null
#
# Indexes
#
#  index_calagator_organization_venues_on_organization_id  (organization_id)
#  index_calagator_organization_venues_on_venues_id        (venues_id)
#
# Foreign Keys
#
#  organization_id  (organization_id => calagator_organizations.id)
#  venues_id        (venues_id => venues.id)
#
module Calagator
  class OrganizationVenue < Calagator::ApplicationRecord
    belongs_to :organization
    belongs_to :venue
  end
end
