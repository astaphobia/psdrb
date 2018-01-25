require 'sinatra'
require 'sinatra/reloader'
require 'psd'
require 'fileutils'
require 'open-uri'
require 'sinatra/json'

set :port => 8080
configure :production do
  enable :reloader
end


get '/' do
    "Hello Guys, ruby here :)"
end

post '/api/test' do 
    content_type :json
    response.body = { :key1 => 'value1', :key2 => 'value2' }.to_json
end

post '/api/upload-psd' do
    directory = './asset/temp_files/'
    url = params['filepath']
    filepath = [directory, params['filename']].join()

    FileUtils::mkdir_p directory

    File.open(filepath, "wb") do |file|
      file.write open(url).read
    end
    output = PSD.open(filepath) do |psd|
        p JSON.generate(psd.tree.to_hash)
        return JSON.generate(psd.tree.to_hash)
    end
    json :output => output
    FileUtils.rm_r directory
end
