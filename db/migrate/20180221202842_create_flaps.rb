class CreateFlaps < ActiveRecord::Migration[5.1]
  def change
    create_table :flaps do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end
    add_index :flaps, [:user_id, :created_at]
  end
end
