# == Schema Information
#
# Table name: calagator_users
#
#  id                     :integer          not null, primary key
#  admin                  :boolean
#  display_name           :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_calagator_users_on_email                 (email) UNIQUE
#  index_calagator_users_on_name                  (name) UNIQUE
#  index_calagator_users_on_reset_password_token  (reset_password_token) UNIQUE
#
module Calagator
  class User < ApplicationRecord
    if Calagator.devise_enabled
      # Include default devise modules. Others available are:
      # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
      devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
    end

    scope :admin, -> { where(admin: true) }
    validates :name, :email, presence: true
    validates :name, format: { with: /\A[a-z0-9\-_]+\z/, message: "only allows ASCII letters, numbers, dashes and underscores" }

    has_many :events, foreign_key: :created_by_id, dependent: :nullify
    has_many :venues, foreign_key: :created_by_id, dependent: :nullify
    has_many :sources, foreign_key: :created_by_id, dependent: :nullify

    before_validation -> { name&.downcase! }, on: :create

    def display_name
      attribute = read_attribute(:display_name)
      attribute.present? ? attribute : name
    end

    def name_with_email
      "@#{name} <#{email}>"
    end
  end
end
