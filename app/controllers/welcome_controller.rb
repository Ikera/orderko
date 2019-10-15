class WelcomeController < ApplicationController
  def index
    @daily_offer = DailyOffer.new(default_daily_offer_params)
    @last_daily_offer = DailyOffer.order(day: :desc).first
  end

  private

  def default_daily_offer_params
    {
      day: Date.today.next_day,
      price: DailyOffer::DEFAULT_MEAL_PRICE,
      shipping: DailyOffer::DEFAULT_SHIPPING_PRICE
    }
  end
end
