class RemoveLikesAndDislikes  < ActiveRecord::Migration
  def change
    remove_column :users, :dislikes, :string
    remove_column :users, :likes, :string
  end
end
