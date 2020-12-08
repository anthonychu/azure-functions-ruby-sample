require 'sinatra'
require 'json'
set :port, ENV['FUNCTIONS_CUSTOMHANDLER_PORT'] || 3000

before do
  content_type :json
end

get '/api/hello' do
  content_type :json
  name = params[:name]
  data = {name: name ? 
    "Hello, #{name}" : 
    'Pass a name in the query string for a personalized response.'}
  data.to_json
end

post '/orders' do
  payload = JSON.parse(request.body.read)
  # print payload["Data"]["req"]["Body"]
  content_type :json
  data = {
    Outputs: {
      queueItem: payload["Data"]["req"]["Body"]
    }
  }
  data.to_json
end

post '/queueTrigger' do
  payload = JSON.parse(request.body.read)
  # print payload["Data"]["req"]["Body"]
  content_type :json
  response = {
    Logs: [
      "Order received: #{payload['Data']['queueItem']}"
    ]
  }
  response.to_json
end