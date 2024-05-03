class CreateCalagatorOrganizations < ActiveRecord::Migration[7.1]
  def change
    create_table :calagator_organizations do |t|
      t.string :name, null: false
      t.string :display_name
      t.string :description
      t.references :primary_venue, foreign_key: { to_table: :venues }

      t.index :name, unique: true
      t.timestamps
    end
  end
end
