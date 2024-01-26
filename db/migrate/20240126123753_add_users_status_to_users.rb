class AddUsersStatusToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :user_status, :integer, default: 0
  end
end
