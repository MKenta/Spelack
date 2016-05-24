class RenameColumnToChannels < ActiveRecord::Migration
  def change
    rename_column :channels, :is_private, :status
    rename_column :channels, :created_user_id, :author_id
  end
end
