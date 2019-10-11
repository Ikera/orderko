class AddClosedToDailyOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :daily_offers, :closed, :boolean, default: false
  end
end
