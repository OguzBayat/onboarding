require "test_helper"

class Api::V1::SyncProgressInfosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_sync_progress_infos_index_url
    assert_response :success
  end
end
