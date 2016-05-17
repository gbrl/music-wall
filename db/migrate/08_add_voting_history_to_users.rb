class AddVotingHistoryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :likes, :string
    add_column :users, :dislikes, :string
  end
end
