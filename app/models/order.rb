class Order < ApplicationRecord
  belongs_to :daily_offer
  belongs_to :consumer

  def total_meal_price
  	daily_offer.price * number_of_meals
  end
end
