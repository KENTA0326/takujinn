class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      # 通報モデル：migration file
      t.integer :reporter_id
      t.integer :reported_id
      t.text :reason, null: false
      t.boolean :checked, default: false
      t.timestamps
    end
  end
end
