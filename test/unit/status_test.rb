require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  should belong_to :user

  test 'that a status requires content to be persisted' do 
    status = Status.new
    assert !status.save
    assert !status.errors[:content].empty?
  end

  test 'that a status\' content must be at least two letters long' do 
    status = Status.new
    status.content = 'h'
    assert !status.save
    assert !status.errors[:content].empty?
  end

  test 'that a status belongs to a user' do 
    status = Status.new
    status.content = 'Hello'
    assert !status.save
    assert !status.errors[:user_id].empty?
  end
end
