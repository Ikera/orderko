class Order < ApplicationRecord
  belongs_to :daily_offer
  belongs_to :consumer

  scope :for_day, -> (day) { includes(:daily_offer).where("daily_offers.day = (?)", day).references(:daily_offer) }

  def total_meal_price
  	daily_offer.price * number_of_meals
  end
end
