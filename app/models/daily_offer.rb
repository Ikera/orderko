class DailyOffer < ApplicationRecord
  DEFAULT_MEAL_PRICE = 250.freeze
  DEFAULT_SHIPPING_PRICE = 220.freeze

  validates :day, :name, :price, :shipping, presence: true
  validates :day, uniqueness: true
  validate :from_monday_to_thursday

  has_many :orders

  scope :for_day, ->(day) { where(day: day) }
  scope :for_days, -> (days) { where(day: days) }

  def shipping_price_per_person
    return 0 if orders.empty?

    (shipping / orders.pluck(:consumer_id).uniq.count)&.ceil
  end

  def self.total(days)
    result = 0
    days.each do |day|
      daily_offer = all.for_day(day).first
      result += (daily_offer.orders.sum(:number_of_meals) * daily_offer.price + daily_offer.shipping) if daily_offer
    end
    result
  end

  def self.paid(days)
    result = 0
    days.each do |day|
      daily_offer = all.for_day(day).first
      result += (daily_offer.orders.meal_paid.sum(:number_of_meals) * daily_offer.price) if daily_offer
      result += (daily_offer.orders.shipping_paid.pluck(:consumer_id).uniq.count * daily_offer.shipping_price_per_person) if daily_offer
    end
    result
  end

  def self.unpaid(days)
    result = 0
    days.each do |day|
      daily_offer = all.for_day(day).first
      result += (daily_offer.orders.meal_unpaid.sum(:number_of_meals) * daily_offer.price) if daily_offer
      result += (daily_offer.orders.shipping_unpaid.pluck(:consumer_id).uniq.count * daily_offer.shipping_price_per_person) if daily_offer
    end
    result
  end

  private

  def from_monday_to_thursday
    errors.add(:day, "must be from Monday to Thursday.") if unallowed_day?
  end

  def unallowed_day?
    day.friday? || day.saturday? || day.sunday?
  end
end
