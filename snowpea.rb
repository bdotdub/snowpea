require 'rubygems'
require 'sinatra'

require 'lib/podcast'
require 'xspf'

require 'cgi'

get '/' do
  haml :index
end

get '/listen' do
  @url = params[:url]
  if @url
    podcast = Snowpea::Podcast.new(:url => @url)
    casts = podcast.casts
    
    @mp3 = casts.collect do |elem| elem.url end
    @title = casts.collect do |elem| elem.title end
    
    @mp3_string = @mp3.join('|')
    @title_string = @title.join("|")
    
    puts "mp3 string: #{@mp3_string}"
    puts "title string: #{@title_string}"
    
    haml :listen
  else
    @notice = 'Please enter a Feed'
    haml :index
  end
end

get '/stylesheets/snowpea.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :snowpea
end

helpers do
  def parse_and_cache
    
  end
end
