require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should have_many :user_friendships
  should have_many :friends

  test 'a user should enter a first name' do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end

  test 'a user should enter a last name' do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end

  test 'a user should enter a profile name' do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test 'a user should have a unique profile name' do
    user = User.new
    user.profile_name = users(:matt).profile_name
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test 'a user should have a profile name without spaces' do
    user = User.new(first_name: 'Matt', last_name: 'Higgins', email: 'blob@example.com')
    user.password = user.password_confirmation = 'password'
    user.profile_name = "Profile name with spaces"
    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?('Must be formatted correctly')
  end

  test 'a user can have a properly formatted profile name' do 
    user = User.new(first_name: 'Matt', last_name: 'Higgins', email: 'blob@example.com')
    user.password = user.password_confirmation = 'password'
    user.profile_name = 'validname10'
    assert user.valid?
  end

  test 'no error is raised when trying to get to a user\'s friends' do 
    assert_nothing_raised do
      users(:matt).friends
    end
  end

  test 'that you can create friendships for a user' do 
    assert_nothing_raised do
      users(:matt).friends << users(:jim)
    end
    users(:matt).friends.reload
    assert users(:matt).friends.include?(users(:jim))
  end

  test 'calling to_param on a user returns the profile name' do
    assert_equal users(:matt).profile_name, users(:matt).to_param
  end
end
