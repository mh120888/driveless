require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: users(:matt).profile_name
    assert_response :success
    assert_template 'profiles/show'
  end

  test 'should render a 404 on profile not found' do 
    get :show, id: 'nil'
    assert_response :not_found
  end

  test 'that variables are assigned on successful profile viewing' do 
    get :show, id: users(:matt).profile_name
    assert assigns(:user)
    assert_not_empty assigns(:statuses)
  end

  test 'only shows the current users\' statuses' do 
    get :show, id: users(:matt).profile_name
    assigns(:statuses).each do |status|
      assert_equal users(:matt), status.user
    end
  end

  setup do
    @friendship = UserFriendship.create(user_id: users(:matt).id, friend_id: users(:jim).id)
  end
  test 'shows pending friend requests' do
    get :show, id: users(:jim).profile_name
    assert assigns(:pending_requests)
    assert_equal assigns(:pending_requests), [@friendship]
  end
end
