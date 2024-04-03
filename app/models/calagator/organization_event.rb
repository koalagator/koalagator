# == Schema Information
#
# Table name: calagator_organization_events
#
#  id              :integer          not null, primary key
#  admin           :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  events_id       :integer          not null
#  organization_id :integer          not null
#
# Indexes
#
#  index_calagator_organization_events_on_events_id        (events_id)
#  index_calagator_organization_events_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  events_id        (events_id => events.id)
#  organization_id  (organization_id => calagator_organizations.id)
#
module Calagator
  class OrganizationEvent < Calagator::ApplicationRecord
    belongs_to :organization
    belongs_to :event
  end
end
