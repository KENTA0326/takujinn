class ChangeCommentsToPostComments < ActiveRecord::Migration[6.1]
  def change
    rename_table :comments, :post_comments
  end
end
