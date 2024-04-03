# == Schema Information
#
# Table name: calagator_organizations
#
#  id           :integer          not null, primary key
#  description  :string
#  display_name :string
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
module Calagator
  class Organization < Calagator::ApplicationRecord
    has_many :organization_users
    has_many :admin_organization_users, -> { where(admin: true) }, foreign_key: :organization_id, class_name: "Calagator::OrganizationUser"
    has_many :users, through: :organization_users
    has_many :admin_users, through: :admin_organization_users, source: :user

    def user_is_admin?(user)
      return false unless user.is_a? User
      admin_users.where(id: user).any?
    end
  end
end
