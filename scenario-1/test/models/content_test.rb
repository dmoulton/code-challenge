require "test_helper"

class ContentTest < ActiveSupport::TestCase
  test 'should save' do
    c = Content.new(data: 'test data')

    assert c.save
    assert_equal 'test data', c.data
  end
end
