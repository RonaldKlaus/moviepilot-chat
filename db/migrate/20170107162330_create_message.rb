class CreateMessage < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :user_id, foreign_key: true
      t.integer :chat_room_id, foreign_key: true

      t.timestamps
    end
  end
end
