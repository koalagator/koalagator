class AddAdminFlagToCalagatorUser < ActiveRecord::Migration[7.1]
  def change
    add_column :calagator_users, :admin, :boolean
  end
end
