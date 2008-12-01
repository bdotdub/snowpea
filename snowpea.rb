require 'rubygems'
require 'sinatra'

require 'lib/podcast'
require 'lib/errors'

require 'cgi'

get '/' do
  haml :index
end

get '/listen' do
  @url = params[:url]
  if @url and not @url.empty?
    begin
      podcast = Snowpea::Podcast.new(:url => @url)
      casts = podcast.casts
    
      if casts.length == 0
        @notice = Snowpea::NoCasts
        haml :podcasturl
      else
        @mp3 = casts.collect do |elem| elem.url end
        @title = casts.collect do |elem| elem.title end
    
        @mp3_string = @mp3.join('|')
        @title_string = @title.join("|")
    
        image = podcast.image
        @image = image.nil? ? '/images/podcast.png' : image
    
        @description = podcast.description
        @title = podcast.title
        @podcast_url = podcast.url
    
        haml :listen
      end
    rescue
      @notice = Snowpea::AmbiguousError
      haml :podcasturl
    end
  else
    @notice = 'Please enter a URL for the Podcast'
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
