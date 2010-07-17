require 'test_helper'

class CdashQuestionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cdash_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cdash_question" do
    assert_difference('CdashQuestion.count') do
      post :create, :cdash_question => { }
    end

    assert_redirected_to cdash_question_path(assigns(:cdash_question))
  end

  test "should show cdash_question" do
    get :show, :id => cdash_questions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cdash_questions(:one).to_param
    assert_response :success
  end

  test "should update cdash_question" do
    put :update, :id => cdash_questions(:one).to_param, :cdash_question => { }
    assert_redirected_to cdash_question_path(assigns(:cdash_question))
  end

  test "should destroy cdash_question" do
    assert_difference('CdashQuestion.count', -1) do
      delete :destroy, :id => cdash_questions(:one).to_param
    end

    assert_redirected_to cdash_questions_path
  end
end
