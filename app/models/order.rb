class Order < ApplicationRecord
  belongs_to :daily_offer
  belongs_to :consumer

  scope :for_day, -> (day) { includes(:daily_offer).where("daily_offers.day = (?)", day).references(:daily_offer) }
  scope :for_days, -> (days) { includes(:daily_offer).where("daily_offers.day IN (?)", days).references(:daily_offer) }
  scope :meal_paid, -> { where(meal_paid: true) }
  scope :shipping_paid, -> { where(shipping_paid: true) }
  scope :meal_unpaid, -> { where(meal_paid: false) }
  scope :shipping_unpaid, -> { where(shipping_paid: false) }

  def total_meal_price
  	daily_offer.price * number_of_meals
  end
end
