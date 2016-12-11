require_relative "../test_helper"

class PageTest < Test::Unit::TestCase

  def setup
    Redis.current.flushdb

    @url = 'https://google.com'
    @uuid = '42'
  end

  def test_find_or_create_by_is_idempotent
    assert_equal 0, Page.find_by(url: @url)[:view_count]

    Page.find_or_create_by(url: @url, uuid: @uuid)
    assert_equal 1, Page.find_by(url: @url)[:view_count]

    Page.find_or_create_by(url: @url, uuid: @uuid)
    assert_equal 1, Page.find_by(url: @url)[:view_count]
  end

  def test_flag_or_create_by_is_idempotent
    Page.find_or_create_by(url: @url, uuid: @uuid)

    assert_equal 0, Page.find_by(url: @url)[:flag_count]

    Page.flag_or_create_by(url: @url, uuid: @uuid)
    assert_equal 1, Page.find_by(url: @url)[:flag_count]

    Page.flag_or_create_by(url: @url, uuid: @uuid)
    assert_equal 1, Page.find_by(url: @url)[:flag_count]
  end
end
