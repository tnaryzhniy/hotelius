class Raiting < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :user

  validates :raiting, presence: true
end
