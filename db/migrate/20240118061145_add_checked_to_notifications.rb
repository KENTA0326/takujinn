class AddCheckedToNotifications < ActiveRecord::Migration[6.1]
  def up
    add_column :notifications, :checked, :boolean, default: false, null: false
  end

  def down
    remove_column :notifications, :checked
  end
end
