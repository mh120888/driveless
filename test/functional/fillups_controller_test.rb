require 'test_helper'

class FillupsControllerTest < ActionController::TestCase

  setup do
    @fillup = fillups(:one)
  end

  context '#index' do
    context 'for an unauthenticated user' do
      should 'redirect to the login page' do
        get :index
        assert_response :redirect
        assert_redirected_to new_user_session_path
      end
    end
    context 'for an authenticated user' do
      setup do
        sign_in users(:matt)
      end
      should 'should get index without error' do
        get :index
        assert_response :success
      end
      should 'assign the current user\'s fillups' do
        get :index
        assert_equal true, assigns(:fillups).include?(fillups(:one))
      end
      should 'not retrieve any fillups belonging to other users' do
        get :index
        assert_equal false, assigns(:fillups).include?(fillups(:two))
      end
    end
  end

  context '#new' do
    context 'for an unauthenticated user' do
      should 'redirect to the login page' do
        get :new
        assert_response :redirect
        assert_redirected_to new_user_session_path
      end
    end
    context 'for an authenticated user' do
      setup do
        sign_in users(:matt)
      end
      should 'should get page with no errors' do
        get :new
        assert_response :success
      end
      should 'assign a new fillup object' do
        get :new
        assert assigns(:fillup)
      end
    end
  end

  context '#create' do
    context 'for an unauthenticated user' do
      should 'redirect to the login page' do
        post :create
        assert_response :redirect
        assert_redirected_to new_user_session_path
      end
    end

    context 'for an authenticated user' do
      setup do
        sign_in users(:matt)
      end
      should 'not create a fillup given incorrect/incomplete params' do
        assert_no_difference('Fillup.count') do
          post :create, fillup: { odometer_reading: @fillup.odometer_reading, price_of_gas: @fillup.price_of_gas, user_id: users(:matt).id }
        end
      end
      should 'create fillup given correct params for the Fillup' do
        assert_difference('Fillup.count') do
          post :create, fillup: { amount_of_gas: @fillup.amount_of_gas, date_of_fillup: @fillup.date_of_fillup, odometer_reading: @fillup.odometer_reading, price_of_gas: @fillup.price_of_gas, user_id: users(:matt).id }
        end
        assert_redirected_to fillup_path(assigns(:fillup))
      end
    end
  end

  context '#show' do
    context 'for an unauthenticated user' do
      should 'redirect to the login page' do
        get :show, id: @fillup
        assert_response :redirect
        assert_redirected_to new_user_session_path
      end
    end
    context 'for an authenticated user' do
      setup do
        sign_in users(:matt)
      end
      should 'should show fillup belonging to current user' do
        get :show, id: @fillup
        assert_response :success
      end
      should 'not show fillup belonging to another user' do
        @other_fillup = fillups(:two)
        get :show, id: @other_fillup
        assert_response :redirect
        assert !flash[:error].empty?
      end
    end
  end
  context '#edit' do
    context 'for an authenticated user' do
      should 'redirect to the login page' do
        get :edit, id: @fillup
        assert_response :redirect
        assert_redirected_to new_user_session_path
      end
    end
    context 'for an authenticated user' do
      setup do
        sign_in users(:matt)
      end
      should 'should get edit page for specified fillup belonging to current user' do
        get :edit, id: @fillup
        assert_response :success
      end
      should 'not show edit form for fillup belonging to another user' do
        @other_fillup = fillups(:two)
        get :edit, id: @other_fillup
        assert_response :redirect
        assert !flash[:error].empty?
      end
    end
  end

  test "should update fillup" do
    put :update, id: @fillup, fillup: { amount_of_gas: @fillup.amount_of_gas, date_of_fillup: @fillup.date_of_fillup, odometer_reading: @fillup.odometer_reading, price_of_gas: @fillup.price_of_gas }
    assert_redirected_to fillup_path(assigns(:fillup))
  end

  test "should destroy fillup" do
    assert_difference('Fillup.count', -1) do
      delete :destroy, id: @fillup
    end

    assert_redirected_to fillups_path
  end
end