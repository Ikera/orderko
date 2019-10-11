class AddPaidOptionsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :meal_paid, :boolean, default: false
    add_column :orders, :shipping_paid, :boolean, default: false
  end
end
