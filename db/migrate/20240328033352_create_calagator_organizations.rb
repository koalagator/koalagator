class CreateCalagatorOrganizations < ActiveRecord::Migration[7.1]
  def change
    create_table :calagator_organizations do |t|
      t.string :name
      t.string :display_name
      t.string :description

      t.timestamps
    end
  end
end
