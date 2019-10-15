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

  def current_monday
    Date.today.beginning_of_week
  end

  def current_tuesday
    current_monday + 1.day
  end

  def current_wednesday
    current_monday + 2.days
  end

  def current_thursday
    current_monday + 3.days
  end

  def weekly_days
    [current_monday, current_tuesday, current_wednesday, current_thursday]
  end

  def active_class(controller)
    'active' if params["controller"] == controller
  end
end
