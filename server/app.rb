require 'cuba'
require 'json'
require 'rack'
require 'rack/contrib'

%w(
 ./config/**/*.rb
 ./lib/**/*.rb
 ./models/**/*.rb
).each do |path|
  Dir[path].sort.each { |rb| require rb }
end

Cuba.plugin Helpers::Request

Cuba.use Rack::PostBodyContentTypeParser

Cuba.define do

  on root do
    reply_with(:json, { version: APP_VERSION })
  end

  on post, 'page_views' do
    require_params(req.params, 'url', 'uuid')

    page = Page.find_or_create_by(
      url: req.params['url'],
      uuid: req.params['uuid']
    )

    reply_with(:json, page, status: 201)
  end

  on post, 'flags' do
    require_params(req.params, 'url', 'uuid')

    page = Page.flag_or_create_by(
      url: req.params['url'],
      uuid: req.params['uuid']
    )

    reply_with(:json, page, status: 201)
  end
end
