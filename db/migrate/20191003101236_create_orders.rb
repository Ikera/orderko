class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.belongs_to :daily_offer, null: false, foreign_key: true
      t.belongs_to :consumer, null: false, foreign_key: true
      t.integer :number_of_meals, default: 1

      t.timestamps
    end
  end
end
