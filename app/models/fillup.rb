class Fillup < ActiveRecord::Base
  attr_accessible :amount_of_gas, :date_of_fillup, :odometer_reading, :price_of_gas, :user_id
  
  belongs_to :user

  validates :amount_of_gas, presence: true
  validates :date_of_fillup, presence: true
  validates :odometer_reading, presence: true
  validates :price_of_gas, presence: true
  
end
