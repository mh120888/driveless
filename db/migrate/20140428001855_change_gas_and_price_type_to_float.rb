class ChangeGasAndPriceTypeToFloat < ActiveRecord::Migration
  def change
   change_column :fillups, :amount_of_gas, :float
   change_column :fillups, :price_of_gas, :float
  end
end
