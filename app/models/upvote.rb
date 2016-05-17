class Upvote < ActiveRecord::Base
  belongs_to :track
  belongs_to :user

    def self.register(track_id,user_id)
      connection = ActiveRecord::Base.connection
      connection.execute("INSERT INTO upvotes (track_id, user_id) VALUES (#{track_id}, #{user_id});") 
    end

end