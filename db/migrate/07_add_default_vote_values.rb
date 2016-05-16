class AddDefaultVoteValues  < ActiveRecord::Migration
  def change
    remove_column :tracks, :up_votes, :integer
    remove_column :tracks, :down_votes, :integer
    add_column :tracks, :up_votes, :integer, default: 0
    add_column :tracks, :down_votes, :integer, default: 0
  end
end
