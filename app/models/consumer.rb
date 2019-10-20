class Consumer < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :orders

  def daily_bill(day)
    orders.for_day(day).map { |order| order.total_meal_price }.sum&.ceil
  end

  def paid_bill?(day)
    orders.for_day(day).pluck(:meal_paid)&.presence&.all?(true)
  end

  def weekly_shipping(days: [])
    orders.for_days(days).map { |o| o.daily_offer }.uniq.map(&:shipping_price_per_person).sum&.ceil
  end

  def paid_weekly_shipping?(days: [])
    orders.for_days(days).pluck(:shipping_paid)&.presence&.all?(true)
  end

  def all_weekly_bills(days: [])
    result = 0
    days.each do |day|
      result += daily_bill(day)
    end

    result += weekly_shipping(days: days)
  end

  def paid_all_weekly_bills?(days: [])
    result = []
    days.each do |day|
      result << paid_bill?(day)
    end

    result << paid_weekly_shipping?(days: days)
    result.compact.presence&.all?(true)
  end

  def paid_weekly_bills(days: [])
    weekly_orders = orders.for_days(days)
    weekly_orders.where(meal_paid: true).map { |order| order.total_meal_price }.sum&.ceil +
    weekly_orders.where(shipping_paid: true).map { |o| o.daily_offer }.uniq.map(&:shipping_price_per_person).sum&.ceil
  end

  def unpaid_weekly_bills(days: [])
    weekly_orders = orders.for_days(days)
    weekly_orders.where(meal_paid: false).map { |order| order.total_meal_price }.sum&.ceil +
    weekly_orders.where(shipping_paid: false).map { |o| o.daily_offer }.uniq.map(&:shipping_price_per_person).sum&.ceil
  end
end
