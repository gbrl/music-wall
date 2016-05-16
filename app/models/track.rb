class Track < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :author, presence: true

  def popularity
    up_votes + down_votes
  end
  
end