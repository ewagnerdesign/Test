require 'test_helper'

class Admin::SdtmsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_sdtms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sdtm" do
    assert_difference('Admin::Sdtm.count') do
      post :create, :sdtm => { }
    end

    assert_redirected_to sdtm_path(assigns(:sdtm))
  end

  test "should show sdtm" do
    get :show, :id => admin_sdtms(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_sdtms(:one).to_param
    assert_response :success
  end

  test "should update sdtm" do
    put :update, :id => admin_sdtms(:one).to_param, :sdtm => { }
    assert_redirected_to sdtm_path(assigns(:sdtm))
  end

  test "should destroy sdtm" do
    assert_difference('Admin::Sdtm.count', -1) do
      delete :destroy, :id => admin_sdtms(:one).to_param
    end

    assert_redirected_to admin_sdtms_path
  end
end
