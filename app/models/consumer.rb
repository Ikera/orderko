class Consumer < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :orders

  def daily_bill(day)
    orders.for_day(day).map { |order| order.total_meal_price }.sum
  end
end
