class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :crypted_password
      t.string :password_salt
      t.string :email
      t.string :firstname
      t.string :lastname

      t.timestamps
    end
  end
end
