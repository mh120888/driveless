class Fillup < ActiveRecord::Base
  attr_accessible :amount_of_gas, :date_of_fillup, :miles_driven, :price_of_gas, :user_id
  
  belongs_to :user

  validates :amount_of_gas, presence: true
  validates :amount_of_gas, numericality: true

  validates :date_of_fillup, presence: true 

  validates :miles_driven, presence: true
  validates :miles_driven, numericality: true

  validates :price_of_gas, presence: true
  validates :price_of_gas, numericality: true
  
  validates :user_id, presence: true
  validates :user_id, numericality: true, numericality: { only_integer: true }

  MONTHS = %w(January February March April May June July August September October November December)

  def calculate_mpg
    miles_driven.to_f/amount_of_gas
  end
end
