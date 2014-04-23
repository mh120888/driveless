require 'test_helper'

class FillupsControllerTest < ActionController::TestCase
  setup do
    @fillup = fillups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fillups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fillup" do
    assert_difference('Fillup.count') do
      post :create, fillup: { amount_of_gas: @fillup.amount_of_gas, date_of_fillup: @fillup.date_of_fillup, odometer_reading: @fillup.odometer_reading, price_of_gas: @fillup.price_of_gas }
    end

    assert_redirected_to fillup_path(assigns(:fillup))
  end

  test "should show fillup" do
    get :show, id: @fillup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fillup
    assert_response :success
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
