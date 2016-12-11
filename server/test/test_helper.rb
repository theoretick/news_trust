ENV["APP_ENV"] = "test"

require "test/unit"
require "rack/test"
require 'mocoso'
require "typhoeus"

require_relative "../app"

class Test::Unit::TestCase

  JSON_HEADERS = { "CONTENT_TYPE" => "application/json; charset=UTF-8" }.freeze

  def startup
    Redis.new.flushdb
  end

  def app
    Cuba.app
  end

  def json_response
    JSON.parse(last_response.body)
  end

  def json_post(route, body)
    post route, JSON.dump(body), JSON_HEADERS
  end
end
