class Review < ActiveRecord::Base
  belongs_to :track
  belongs_to :user

  validates :rating, presence: :true, :numericality => { only_integer: true, :greater_than => 0, :less_than_or_equal_to => 5 }
  validates :content, presence: :true

end