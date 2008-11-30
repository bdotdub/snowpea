require 'rubygems'
require 'sinatra'

require 'lib/podcast'
require 'xspf'

get '/' do
  haml :index
end

get '/listen' do
  @url = params[:url]
  if @url
    @playlist = '/xspf/playlist.xml'
    haml :listen
  else
    @notice = 'Please enter a Feed'
    haml :index
  end
end

get '/xspf' do
  @url = params[:url]
  @xspf = ''
  
  podcast = Snowpea::Podcast.new(:url => @url)
  time2 = Time.now.to_i
  
  @xspf = podcast.to_xspf().to_xml
  
  f = File.open('public/xspf/playlist.xml', 'w')
  f.write(@xspf)
  f.close
  
  haml :index
end

get '/stylesheets/snowpea.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :snowpea
end

helpers do
  def parse_and_cache
    
  end
end
