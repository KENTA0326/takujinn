class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.text :text
      t.string :location
      t.string :btype
      t.timestamps
    end
  end
end
