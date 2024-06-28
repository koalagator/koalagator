class AddPinnedToVenue < ActiveRecord::Migration[7.1]
  def change
    add_column :venues, :pinned, :boolean, null: false, default: false
  end
end
