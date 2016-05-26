class AddSoftDestroyedAtToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :delete_at, :datetime
    add_index :channels, :delete_at
  end
end
