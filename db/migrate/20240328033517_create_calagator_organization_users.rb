class CreateCalagatorOrganizationUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :calagator_organization_users do |t|
      t.references :organization, null: false, foreign_key: {to_table: :calagator_organizations}
      t.references :user, null: false, foreign_key: {to_table: :calagator_users}
      t.boolean :admin

      t.timestamps
    end
  end
end
