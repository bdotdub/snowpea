require 'rubygems'
require 'open-uri'
require 'syndication/rss'
require 'syndication/podcast'

parser = Syndication::RSS::Parser.new
feed = parser.parse open('http://feeds.feedburner.com/tacksharp').read

require 'pp'

pp feed


