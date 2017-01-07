class CreateChatRoom < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_rooms do |t|
      t.string :title
      t.text :description
      t.integer :user_id, foreign_key: true

      t.timestamps
    end
  end
end
