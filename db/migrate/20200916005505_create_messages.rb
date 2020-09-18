class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :title
      t.integer :receiver_id
      t.integer :sender_id
      t.boolean :read, null: false, default: false
      t.text :content

      t.timestamps
    end
    add_index :messages, :receiver_id
    add_index :messages, :sender_id
  end
end
