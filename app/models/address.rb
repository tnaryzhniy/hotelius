class Address < ActiveRecord::Base
  belongs_to :hotel

  validates :country, length: {maximum: 50}, allow_blank: true
  validates :state, length: {maximum: 50}, allow_blank: true
  validates :city, length: {maximum: 50}, allow_blank: true
  validates :street, length: {maximum: 50}, allow_blank: true
end
