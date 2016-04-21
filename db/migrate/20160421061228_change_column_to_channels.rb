class ChangeColumnToChannels < ActiveRecord::Migration
  def change
    change_column :channels, :status, :integer, default: 0, :null => false
  end
end
