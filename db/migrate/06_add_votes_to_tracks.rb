class AddVotesToTracks  < ActiveRecord::Migration
  def change
    add_column :tracks, :up_votes, :integer
    add_column :tracks, :down_votes, :integer
  end
end
