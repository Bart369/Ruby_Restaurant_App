class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :session_token
      t.string :password_digest

      t.timestamps
    end
  # we are adding an index so ruby can look them up 
  # increasing efficiency
  add_index :users, :username
  add_index :users, :session_token

  end
end
