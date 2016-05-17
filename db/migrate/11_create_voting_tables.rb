class CreateVotingTables  < ActiveRecord::Migration
  def change

    create_table :downvotes do |t|
      t.integer  :track_id
      t.integer  :user_id
    end

    create_table :upvotes do |t|
      t.integer  :track_id
      t.integer  :user_id
    end

  end
end
