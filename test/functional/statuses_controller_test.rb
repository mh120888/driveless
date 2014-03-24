require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  setup do
    @status = statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

  test 'should be redirected when not logged in' do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test 'should render the new page when logged in' do 
    sign_in users(:matt)
    get :new
    assert_response :success
  end

  test 'should be logged in to post a status' do
    post :create, status: { content: 'Random stuff' }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should create status when logged in" do
    sign_in users(:matt)
    assert_difference('Status.count') do
      post :create, status: { content: @status.content }
    end

    assert_redirected_to status_path(assigns(:status))
  end

  test "should create status for current user when logged in" do
    sign_in users(:matt)
    assert_difference('Status.count') do
      post :create, status: { content: @status.content, user_id: users(:matt).id }
    end

    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:matt).id
  end

  test "should show status when logged in and viewing one's own status" do
    sign_in users(:matt)
    get :show, id: @status
    assert_response :success
  end

  test 'should redirect when trying to view show status another user' do
    sign_in users(:jim)
    get :show, id: @status
    assert_response :redirect
  end

  test "should get edit when logged in" do
    sign_in users(:matt)
    get :edit, id: @status
    assert_response :success
  end

  test 'should be redirected to log in if not logged in' do 
    get :edit, id: @status
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should update status" do
    put :update, id: @status, status: { content: 'new status!' }
    assert_redirected_to status_path(assigns(:status))
  end

  test "should not update status if status was not changed" do
    put :update, id: @status, status: { content: @status.content }
    assert_response :unprocessable_entity
  end

  test "should destroy status" do
    assert_difference('Status.count', -1) do
      delete :destroy, id: @status
    end

    assert_redirected_to statuses_path
  end
end
