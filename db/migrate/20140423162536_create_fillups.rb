class CreateFillups < ActiveRecord::Migration
  def change
    create_table :fillups do |t|
      t.integer :miles_driven
      t.integer :amount_of_gas
      t.integer :price_of_gas
      t.date :date_of_fillup

      t.timestamps
    end
  end
end
