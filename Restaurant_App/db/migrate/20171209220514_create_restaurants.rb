class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :type
      t.string :bestdish

      t.timestamps
    end
  end
end
