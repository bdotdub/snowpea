require 'rubygems'
require 'open-uri'
require 'nokogiri'

module Snowpea
  class Podcast
    def initialize(args)
      if not args[:url]
        raise ArgumentError.new('Podcast URL not provided')
      end

      begin
        @handle = open(args[:url])
        @feed = Nokogiri::XML @handle
      rescue OpenURI::HTTPError => e
      end
    end
    
    def feed
      @feed
    end
    
    def casts
      casts = []
      @feed.xpath('//item').each do |item|
        url = title = ''
        
        item.children.each do |child|
          title = child.content if child.name =~ /^title$/i
          url = child.attributes['url'] if child.name =~ /^enclosure$/i
        end
        
        puts "url #{url}, title #{title}"

        cast = PodcastElement.new :url => url, :title => title
        casts.push cast
      end
      
      return casts
    end
  end
  
  class PodcastElement
    attr_accessor :title, :url
    
    def initialize(args)
      if not args[:url]
        raise ArgumentError.new("Missing title or URL for podcast element")
      end
      
      self.url = args[:url]
      self.title = (args[:title]) ? args[:title] : args[:url]
    end
  end
end
