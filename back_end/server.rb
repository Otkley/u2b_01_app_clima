require 'bundler'; Bundler.require
require 'sinatra'
require 'net/http'
require 'json'
require 'sinatra/cross_origin' # Para permitir peticiones en el proyecto

configure do
  enable :cross_origin
end

set :allow_origin, :any
set :allow_methods, [:get]
set :allow_credentials, true

get '/weather' do
  # la respuesta que daremos sera en formato json
  content_type :json
  base_url = 'http://api.weatherstack.com'
  api_key = 'ae2341d64533339f78b4574f533c3555'
  method = '/current'
  location = params[:location]

  url = "#{base_url}#{method}?access_key=#{api_key}&query=#{location}"
  puts url

  url = URI.parse(url) # Instancia de la ruta
  http = Net::HTTP.new(url.host, url.port) # Instancia el cliente http
  response = http.get(url.request_uri) # Instancia de la respuesta

  body = JSON.parse(response.body)
  puts "-> Codigo: #{response.code}"
  puts "-> Cuerpo: #{body}"

  if response.code != '200'
    status 500
    { error: 'Error al obtener el clima' }
  else
    body.to_json
  end
end
