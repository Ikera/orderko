class CreateDailyOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_offers do |t|
      t.date :day, null: false, unique: true
      t.string :name, null: false
      t.float :price, null: false
      t.float :shipping, null: false

      t.timestamps
    end
  end
end
