require 'rubygems'
require 'open-uri'
require 'nokogiri'

module Snowpea
  class Podcast
    ITUNES_NS = 'http://www.itunes.com/dtds/podcast-1.0.dtd'
    
    attr_reader :feed
    
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
    
    def image
      image = @feed.xpath('//channel/image/url').text
      
      if not image or image == ''
        image = @feed.xpath('//itunes:image/@href', 'itunes' => ITUNES_NS).text
      end
        
      return nil if not image or image == ''
      return image
    end
    
    def title
      title = @feed.xpath('//channel/title').text
      
      return nil if not title or title == ''
      return title
    end
    
    def url
      link = @feed.xpath('//channel/link').text
      
      return nil if not link or link == ''
      return link
    end
    
    def description
      description = @feed.xpath('//channel/description').text
      
      return nil if not description or description == ''
      return description
    end
    
    def casts
      casts = []
      @feed.xpath('//item').each do |item|
        url = title = ''
        
        item.children.each do |child|
          title = child.content if child.name =~ /^title$/i
          url = child.attributes['url'] if child.name =~ /^enclosure$/i
        end
        
        begin
          cast = PodcastElement.new :url => url, :title => title
          casts.push cast
        rescue ArgumentError => e
        end
      end
      
      return casts
    end
  end
  
  class PodcastElement
    attr_accessor :title, :url
    
    def initialize(args)
      if args[:url] == ''
        raise ArgumentError.new("Missing title or URL for podcast element")
      end
      
      self.url = args[:url]
      self.title = (args[:title]) ? args[:title] : args[:url]
    end
  end
end
