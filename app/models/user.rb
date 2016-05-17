class User < ActiveRecord::Base
  has_secure_password
  
  has_many :tracks
  has_many :upvotes, dependent: :destroy
  has_many :downvotes, dependent: :destroy
  
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true

  before_create :lowercase_username

  private 
  
  def lowercase_username
    username.downcase!
  end

end