class CreateCalagatorOrganizationVenues < ActiveRecord::Migration[7.1]
  def change
    create_table :calagator_organization_venues do |t|
      t.references :organization, null: false, foreign_key: {to_table: :calagator_organizations}
      t.references :venues, null: false, foreign_key: true
      t.boolean :admin

      t.timestamps
    end
  end
end
