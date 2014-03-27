require 'test_helper'

class AddAFriendTest < ActionDispatch::IntegrationTest
  def sign_in_as(user, password)
    post login_path, user: { email: user.email, password: password }
  end
  test 'that a user can add a friend' do
    sign_in_as users(:matt), 'testing'
    get "/user_friendships/new?friend_id=#{users(:matt).id}"
    assert_response :success
    assert_difference "UserFriendship.count" do
      post '/user_friendships', { :user_friendship =>
                    {:friend_id => users(:jim).id }
                  } 
      assert_response :redirect
      assert_equal "You are now friends with #{users(:jim).full_name}", flash[:success] 
    end
  end
end
