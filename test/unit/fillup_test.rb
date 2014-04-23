require 'test_helper'

class FillupTest < ActiveSupport::TestCase
  should belong_to :user

  test 'that a fillup requires amount of gas to be persisted' do
    fillup = Fillup.new
    assert !fillup.save
    assert !fillup.errors[:amount_of_gas].empty?
  end

  test 'that a fillup requires an odometer reading to be persisted' do
    fillup = Fillup.new
    assert !fillup.save
    assert !fillup.errors[:odometer_reading].empty?
  end

  test 'that a fillup requires a date of fillup to be persisted' do
    fillup = Fillup.new
    assert !fillup.save
    assert !fillup.errors[:date_of_fillup].empty?
  end

  test 'that a fillup requires a gas price to be persisted' do
    fillup = Fillup.new
    assert !fillup.save
    assert !fillup.errors[:price_of_gas].empty?
  end
end
