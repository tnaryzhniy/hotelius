class Hotel < ActiveRecord::Base
  belongs_to :user
  has_one :address
  has_many :raitings

  accepts_nested_attributes_for :address

  mount_uploader :foto, FotoUploader

  VALID_PRICE_REGEX = /\A[-+]?(\d*[.])?\d+\z/

  validates :title, presence: true, length: {minimum: 3, maximum: 80}
  validates :stars, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
  validates :price, allow_blank: true, format: { with: VALID_PRICE_REGEX }

  def create_raiting(parameters)
    @raiting = raitings.build(parameters)
    update_raiting
  end

  def self.top_five
    Hotel.order(aver_raiting: :desc).first(5)
  end

  private

  def update_raiting
    aver = raitings.average('raiting')
    update(aver_raiting: aver)
  end

end
