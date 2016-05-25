class RenameChatsToMessages < ActiveRecord::Migration
  def change
    rename_table :chats, :messages
  end
end
