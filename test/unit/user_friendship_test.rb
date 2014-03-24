require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to :user
  should belong_to :friend

  test 'a friendship can be created without throwing an error' do 
    assert_nothing_raised do
      UserFriendship.create(user: users(:matt), friend: users(:jim))
    end
  end

  test 'you can create a friendship using user_id and friend_id' do 
    assert_nothing_raised do
      UserFriendship.create(user_id: users(:matt).id, friend_id: users(:jim).id)
    end
  end
end
