require "test_helper"

class Api::V1::OnboardingStepsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_onboarding_steps_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_onboarding_steps_show_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_onboarding_steps_create_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_onboarding_steps_update_url
    assert_response :success
  end
end
