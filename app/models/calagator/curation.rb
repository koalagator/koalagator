# == Schema Information
#
# Table name: calagator_curations
#
#  id           :integer          not null, primary key
#  description  :string
#  display_name :string
#  name         :string           not null
#  priority     :integer          default(0), not null
#  unlisted     :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_calagator_curations_on_name  (name) UNIQUE
#
module Calagator
  class Curation < Calagator::ApplicationRecord
    include EventFilterable

    validates :name, :display_name, :priority, presence: true
    validates :name,
      format: { with: /\A[a-z0-9\-_]+\z/, message: "only allows ASCII letters, numbers, dashes and underscores" },
      uniqueness: true,
      length: { maximum: 64 }
    
    scope :order_by_priority, ->(direction = :desc) { order(priority: direction) }
    scope :listed, ->(listed = true) { where(unlisted: !listed) }
  end
end
