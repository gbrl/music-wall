class Track < ActiveRecord::Base
  belongs_to :user

  has_many :downvotes, dependent: :destroy
  has_many :upvotes, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :author, presence: true

  def popularity
    upvotes.count - downvotes.count
  end
  
end