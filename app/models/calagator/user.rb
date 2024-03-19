# == Schema Information
#
# Table name: calagator_users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_calagator_users_on_email                 (email) UNIQUE
#  index_calagator_users_on_reset_password_token  (reset_password_token) UNIQUE
#
module Calagator
  class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

    if Calagator.devise_enabled
      devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
    end
  end
end
