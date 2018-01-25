require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/namespace'
require 'psd'
require 'fileutils'
require 'open-uri'

set :port => 8080
configure :production do
  enable :reloader
end


get '/' do
    "Hello Guys, ruby here :)"
end
    
post '/api/upload-psd' do
    directory = './asset/temp_files/'
    url = params['filepath']
    filepath = [directory, params['filename']].join()

    FileUtils::mkdir_p directory

    File.open(filepath, "wb") do |file|
      file.write open(url).read
    end
    psd = PSD.new(filepath)
    psd.parse!
    print psd
end
