module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}", role: "alert") do
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end

  def week_day(day)
    Date::DAYNAMES[day.cwday - 7]
  end

  def formatted_date(date)
    date.strftime("%d.%m.%Y.")
  end

  def monday(date = nil)
    (date.presence ? date.to_date : Date.today).beginning_of_week
  end

  def tuesday(date = nil)
    monday(date) + 1.day
  end

  def wednesday(date = nil)
    monday(date) + 2.days
  end

  def thursday(date = nil)
    monday(date) + 3.days
  end

  def weekly_days(date = nil)
    [monday(date), tuesday(date), wednesday(date), thursday(date)]
  end

  def daily_bill(consumer, day)
    daily_bill = consumer.daily_bill(day)
    daily_bill.zero? ? "-" :  daily_bill
  end

  def paid_weekly_bills(consumer, days)
    paid_weekly_bills = consumer.paid_weekly_bills(days: days)
    paid_weekly_bills.zero? ? "-" : paid_weekly_bills
  end

  def unpaid_weekly_bills(consumer, days)
    unpaid_weekly_bills = consumer.unpaid_weekly_bills(days: days)
    unpaid_weekly_bills.zero? ? "-" : unpaid_weekly_bills
  end

  def all_weekly_bills(consumer, days)
    all_weekly_bills = consumer.all_weekly_bills(days: days)
    all_weekly_bills.zero? ? "-" : all_weekly_bills
  end

  def shipping(day)
    DailyOffer.for_day(day)&.first&.shipping_price_per_person
  end

  def consumer_weekly_shipping(consumer, days)
    weekly_shipping = consumer.weekly_shipping(days: days)
    weekly_shipping.zero? ? "-" : weekly_shipping
  end

  def weekly_shipping(days)
    DailyOffer.for_days(days).map(&:shipping_price_per_person).compact.presence&.sum
  end

  def week(date)
    "#{formatted_date(monday(date))} - #{formatted_date(thursday(date))}"
  end

  def active_class(controller)
    'active' if params["controller"] == controller
  end
end
