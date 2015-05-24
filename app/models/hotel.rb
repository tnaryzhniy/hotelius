class Hotel < ActiveRecord::Base
  belongs_to :user
  has_one :address, dependent: :destroy
  has_many :raitings, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true

  mount_uploader :foto, FotoUploader

  validates :title, presence: true, length: {minimum: 3, maximum: 80}, uniqueness:{ case_sensitive: false }
  validates :stars, presence: true
  validates :price, numericality: { greater_than: 0, less_than: 999999 }, allow_nil: true

  def self.top_five
    Hotel.order(aver_raiting: :desc).first(5)
  end

  def update_raiting
    aver = raitings.average('raiting')
    update(aver_raiting: aver)
  end

end
