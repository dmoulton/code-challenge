require "test_helper"

class ContentControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get content_index_url
    assert_response :success
    assert_equal 'application/json; charset=utf-8', @response.content_type
  end

  test 'should return rotified text in JSON format with valid params' do
    post content_save_url, params: { data: '-rotified text-' }
    
    assert_response :success
    assert_equal 'application/json; charset=utf-8', @response.content_type
    
    json_response = JSON.parse(@response.body)
    assert_equal '-ebgvsvrq grkg-', json_response['encoded_text']
  end

  test 'should create content object in the db' do
    assert_difference('Content.count') do
      post content_save_url, params: { data: 'object save test' }
    end
  
    assert_equal 'object save test', Content.last.data
  end
end
