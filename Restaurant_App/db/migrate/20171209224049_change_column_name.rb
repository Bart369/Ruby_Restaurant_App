class ChangeColumnName < ActiveRecord::Migration[5.1]
  # i did this to change the type column to type since i cant use type
  # i did rails g migration ChangeColumnName to creat this
  def change
    rename_column :restaurants, :type, :kind
  end
end
