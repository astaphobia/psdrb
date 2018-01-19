require 'sinatra'
require 'sinatra/reloader'
require 'psd'

set :port => 8080
configure :production do
  enable :reloader
end

get '/upload-psd' do
    path = './assets/temp_files/'
    psd = PSD.open(path + request.body)
end
