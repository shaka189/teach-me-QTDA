class CreateConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :conversations do |t|
      t.integer :newbie_id
      t.integer :expert_id
      t.references :request, foreign_key: true
      t.boolean :done, default: false
      t.float :rate_point

      t.timestamps
    end
    add_index :conversations, :newbie_id
    add_index :conversations, :expert_id
  end
end
