class AddCreatedByToRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :created_by_name, :string
    add_reference :events, :created_by, foreign_key: { to_table: :calagator_users }

    add_column :venues, :created_by_name, :string
    add_reference :venues, :created_by, foreign_key: { to_table: :calagator_users }

    add_column :sources, :created_by_name, :string
    add_reference :sources, :created_by, foreign_key: { to_table: :calagator_users }
  end
end
