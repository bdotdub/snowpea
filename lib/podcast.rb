require 'rubygems'
require 'open-uri'
require 'syndication/rss'
require 'syndication/podcast'

require 'xspf'

module Snowpea
  class Podcast
    def initialize(args)
      if not args[:url]
        raise ArgumentError.new('Podcast URL not provided')
      end

      @parser = Syndication::RSS::Parser.new
      @feed = @parser.parse open(args[:url])
    end
    
    def to_xspf
      @trackList = XSPF::Tracklist.new
      @feed.items.each do |item|
        @trackList << XSPF::Track.new(
          :location   => item.enclosure.url,
          :identifier => item.guid,
          :title      => item.title,
          :image      => @feed.channel.itunes_image['href']
        )
      end
      
      playlist = XSPF::Playlist.new( {
         :xmlns => 'http://xspf.org/ns/0/',
         :title => 'Tout est calme',
         :creator => 'Yann Tiersen',
         :license => 'Redistribution or sharing not allowed',
         :info => 'http://www.yanntiersen.com/',
         :tracklist => @trackList,
         :meta_rel => 'http://www.example.org/key',
         :meta_content => 'value',
       })
       xspf = XSPF.new( { :playlist => playlist } )
       
       return xspf
    end
  end
end
