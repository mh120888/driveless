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
      assert users(:matt).pending_friends.include?(users(:jim))
    end
  end

  context 'a new instance' do
    setup do
      @user_friendship = UserFriendship.new user: users(:matt), friend: users(:jim)
    end

    should 'initially have a state of pending' do
      assert_equal 'pending', @user_friendship.state
    end

    should 'only be created if a UserFriendship does not already exist for the two users' do
      @user_friendship.save
      @second_user_friendship = UserFriendship.new user: users(:matt), friend: users(:jim)
      assert_equal false, @second_user_friendship.save
    end
  end

  context '#send_request_email' do
    setup do
      @user_friendship = UserFriendship.create user: users(:matt), friend: users(:jim)
    end

    should 'send an email' do
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        @user_friendship.send_request_email
      end
    end
  end

  context '#accept!' do
    setup do
      @user_friendship = UserFriendship.create user: users(:matt), friend: users(:jim)
    end

    should 'set the state to accepted' do
      @user_friendship.accept!
      assert_equal 'accepted', @user_friendship.state
    end

    should 'send an acceptance email' do
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        @user_friendship.accept!
      end
    end

    should 'include the friend in the user\'s list of friends' do
      @user_friendship.accept!
      users(:matt).friends.reload
      assert users(:matt).friends.include?(users(:jim))
    end
  end
end







