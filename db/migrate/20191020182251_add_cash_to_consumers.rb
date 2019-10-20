class AddCashToConsumers < ActiveRecord::Migration[6.0]
  def change
  	add_column :consumers, :cash, :integer, default: 0
  end
end
