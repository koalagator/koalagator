class AddNameToCalagatorUser < ActiveRecord::Migration[7.1]
  def change
    add_column :calagator_users, :name, :string, null: false
    add_column :calagator_users, :display_name, :string

    add_index :calagator_users, :name, unique: true
  end
end
