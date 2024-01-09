class RemoveMailFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :mail, :integer
  end
end
