# == Schema Information
#
# Table name: calagator_organization_events
#
#  id              :integer          not null, primary key
#  admin           :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  event_id        :integer          not null
#  organization_id :integer          not null
#
# Indexes
#
#  index_calagator_organization_events_on_event_id         (event_id)
#  index_calagator_organization_events_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  event_id         (event_id => events.id)
#  organization_id  (organization_id => calagator_organizations.id)
#
module Calagator
  class OrganizationEvent < Calagator::ApplicationRecord
    belongs_to :organization
    belongs_to :event

    scope :admin, ->(admin = true) { where(admin: admin) }
  end
end
