class Consumer < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :orders

  def daily_bill(day)
    orders.for_day(day).map { |order| order.total_meal_price }.sum
  end

  def paid_bill(day)
    orders.for_day(day).pluck(:meal_paid)&.presence&.all?(true)
  end

  def weekly_shipping(days: [])
    orders.for_days(days).map { |o| o.daily_offer }.uniq.map(&:shipping_price_per_person).sum
  end

  def paid_weekly_shipping(days: [])
    orders.for_days(days).pluck(:shipping_paid)&.presence&.all?(true)
  end
end
