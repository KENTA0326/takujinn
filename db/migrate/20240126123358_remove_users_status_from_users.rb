class RemoveUsersStatusFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :user_status, :integer
  end
end
