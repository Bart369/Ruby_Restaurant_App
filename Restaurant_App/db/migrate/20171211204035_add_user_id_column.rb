class AddUserIdColumn < ActiveRecord::Migration[5.1]
  #migrations i had to make to add user_id for each restaurant
  # I dont think add_column :restaurants, :user, index: true would have worked
  # since it has to belong to a a specific user?
  def change
    add_belongs_to :restaurants, :user
  end
end
