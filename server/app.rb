require 'cuba'
require 'json'
require 'rack'
require 'rack/contrib'

%w(
 ./config/**/*.rb
 ./lib/**/*.rb
).each do |path|
  Dir[path].sort.each { |rb| require rb }
end

Cuba.plugin Helpers::Request

Cuba.use Rack::PostBodyContentTypeParser

Cuba.define do

  on root do
    reply_with(:json, { version: APP_VERSION })
  end
end
