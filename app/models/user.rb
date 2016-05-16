class User < ActiveRecord::Base
  has_many :tracks
  has_one :session
  
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true

  before_create :lowercase_username

  private 
  
  def lowercase_username
    username.downcase!
  end

end