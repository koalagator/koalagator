# == Schema Information
#
# Table name: calagator_organization_users
#
#  id              :integer          not null, primary key
#  admin           :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :integer          not null
#  user_id         :integer          not null
#
# Indexes
#
#  index_calagator_organization_users_on_organization_id  (organization_id)
#  index_calagator_organization_users_on_user_id          (user_id)
#
# Foreign Keys
#
#  organization_id  (organization_id => calagator_organizations.id)
#  user_id          (user_id => calagator_users.id)
#
module Calagator
  class OrganizationUser < Calagator::ApplicationRecord
    belongs_to :organization
    belongs_to :user
  end
end
