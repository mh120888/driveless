require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase
  context '#new' do 
    context 'for an unauthenticated user' do
      should 'redirect to login page' do 
        get :new
        assert_response :redirect
      end
    end
    context 'for an authenticated user' do 
      setup do
        sign_in users(:matt)
      end
      should 'render the new page' do
        get :new
        assert_response :success
      end
      should 'set a flash error if friend_id is not specified' do
        get :new, {}
        assert_equal 'Friend required', flash[:error]
      end
      should 'display the friend\'s name' do
        get :new, {friend_id: users(:jim).id}
        assert_match /#{users(:jim).full_name}/, response.body
      end
      should 'assign a new user friendship object with friend as specified friend' do
        get :new, {friend_id: users(:jim).id}
        assert_equal users(:jim), assigns(:user_friendship).friend
      end
      should 'assign a new user friendship object with user as currently signed in user' do
        get :new, {friend_id: users(:jim).id, user_id: users(:matt).id}
        assert_equal users(:matt), assigns(:user_friendship).user
      end
      should 'return 404 status if no friend is found' do
        get :new, friend_id: 'invalid'
        assert_response :not_found
      end
      should 'ask if you really want to request this friendship' do
        get :new, {friend_id: users(:jim).id, user_id: users(:matt).id}
        assert_match /Do you really want to friend #{users(:jim).full_name}?/, response.body
      end
    end
  end

  context '#create' do
    context 'for an unauthenticated user' do
      should 'redirect to login page' do 
        post :create
        assert_response :redirect
        assert_redirected_to new_user_session_path
      end
    end
    context 'for an authenticated user' do
      setup do
        sign_in users(:matt)
      end
      context 'with no friend ID' do
        setup do
          post :create
        end
        should 'display the appropriate error message' do
          assert !flash[:error].empty?
        end
        should 'redirect to root path' do
          assert_redirected_to '/'
        end
      end
      context 'with a valid friend ID' do
        setup do
          post :create, { :user_friendship =>
                    {:friend_id => users(:jim).id }
                  } 
        end
        should 'assign a friend object' do
          assert assigns(:friend)
          assert_equal assigns(:friend), users(:jim)
        end
        should 'assign a user_friendship object' do
          assert assigns(:user_friendship)
          assert_equal assigns(:user_friendship).friend, users(:jim)
          assert_equal assigns(:user_friendship).user, users(:matt)
        end
        # should 'create a friendship' do
        #   assert users(:matt).friends.include?(users(:jim))
        # end
        should 'redirect to the profile page of the friend' do
          assert_redirected_to profile_path(users(:jim))
        end
        should 'display the appropriate flash message' do
          assert flash[:success]
          assert_equal "You have requested to be friends with #{users(:jim).full_name}", flash[:success]
        end
      end
    end
  end
end
