class CreateCalagatorCurations < ActiveRecord::Migration[7.1]
  def change
    create_table :calagator_curations do |t|
      t.string :name, null: false
      t.string :display_name
      t.string :description
      t.integer :priority, null: false, default: 0
      t.boolean :unlisted, null: false, default: false

      t.timestamps
    end

    add_index :calagator_curations, :name, unique: true
  end
end
