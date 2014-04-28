class AddUserIdToFillups < ActiveRecord::Migration
  def change
    add_column :fillups, :user_id, :integer
    add_index :fillups, :user_id
  end
end
