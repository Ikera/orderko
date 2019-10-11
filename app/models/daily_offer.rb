class DailyOffer < ApplicationRecord
  DEFAULT_MEAL_PRICE = 250.freeze
  DEFAULT_SHIPPING_PRICE = 220.freeze

  validates :day, :name, :price, :shipping, presence: true
  validates :day, uniqueness: true

  has_many :orders

  scope :for_day, ->(day) { where(day: day) }

  def shipping_price_per_person
    return 0 if orders.empty?

    shipping / orders.pluck(:consumer_id).uniq.count
  end
end
