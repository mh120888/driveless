require 'test_helper'

class FillupTest < ActiveSupport::TestCase
  should belong_to :user

  test 'that a fillup requires amount of gas to be persisted' do
    fillup = Fillup.new
    assert !fillup.save
    assert !fillup.errors[:amount_of_gas].empty?
  end

  test 'that a fillup requires miles driven to be persisted' do
    fillup = Fillup.new
    assert !fillup.save
    assert !fillup.errors[:miles_driven].empty?
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

  context '#calculate_mpg' do
    should 'correctly calculate mpg for a given fillup' do
      fillup = Fillup.new({amount_of_gas: 10, miles_driven: 100})
      assert_equal 10.0, fillup.calculate_mpg
    end
  end
end
