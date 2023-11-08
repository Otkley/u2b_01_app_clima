require "bundler"; Bundler.require
require "sinatra"

get "/weather" do
  # la respuesta que daremos sera en formato json
  content_type :json 
end