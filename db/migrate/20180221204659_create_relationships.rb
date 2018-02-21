class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :cause_id
      t.integer :effect_id

      t.timestamps
    end
    add_index :relationships, :cause_id
    add_index :relationships, :effect_id
    add_index :relationships, [:cause_id, :effect_id], unique: true
  end
end
