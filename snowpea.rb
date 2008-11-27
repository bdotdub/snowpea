require 'rubygems'
require 'sinatra'

get '/' do
  haml :index
end

get '/listen' do
  @url = params[:url]
  if @url
    haml '= @url'
  else
  end
end

