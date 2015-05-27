class Raiting < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :user

  validates :comment, length: {maximum: 500}
  validates :raiting, presence: true
  validates :user_id, presence: true
  validates :hotel_id, presence: true
end
