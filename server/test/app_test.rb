require_relative './test_helper'

class AppTest < Test::Unit::TestCase
  include Rack::Test::Methods
  include Mocoso

  def test_root_returns_app_version
    get '/'

    assert last_response.ok?
    assert_equal %w(version), json_response.keys
  end

  def test_post_page_views
    url = "https://google.com"
    uuid =  "42"

    expect(Page, :find_or_create_by, with: [{ url: url, uuid: uuid }], return: {}) do
      json_post '/page_views', { url: url, uuid: uuid }
    end

    assert_equal 201, last_response.status
  end

  def test_post_flags
    url = "https://google.com"
    uuid =  "42"

    expect(Page, :flag_or_create_by, with: [{ url: url, uuid: uuid }], return: {}) do
      json_post '/flags', { url: url, uuid: uuid }
    end

    assert_equal 201, last_response.status
  end
end
