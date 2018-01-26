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
    "Hello Guys, Ruby here :)"
end
get '/' do 
    'Hello'
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
        return psd.tree.to_json
    end
    json :output => output
    FileUtils.rm_r directory
end
