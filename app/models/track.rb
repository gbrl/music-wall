class Track < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :author, presence: true

  before_create :start_votes

  def start_votes
    down_votes = 0
    up_votes   = 0
  end

  def popularity
    up_votes + down_votes
  end
  
end