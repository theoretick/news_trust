require_relative './test_helper'

class AppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def test_root_returns_app_version
    get '/'

    assert last_response.ok?
    assert_equal %w(version), json_response.keys
  end
end
