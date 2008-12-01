require 'rubygems'
require 'open-uri'
require 'hpricot'

module Snowpea
  class Podcast
    ITUNES_NS = 'http://www.itunes.com/dtds/podcast-1.0.dtd'
    
    attr_reader :feed
    
    def initialize(args)
      if not args[:url] or args[:url].empty?
        raise ArgumentError.new('Podcast URL not provided')
      end

      @handle = open(args[:url])
      @feed = Hpricot.XML @handle
    end
    
    def image
      image = (@feed/:channel/:image/:url).text
      
      if not image or image == ''
        image = (@feed/:channel).%('itunes:image')['href']
      end
        
      return nil if not image or image == ''
      return image
    end
    
    def title
      title = (@feed/:channel/:title).text
      
      return nil if not title or title == ''
      return title
    end
    
    def url
      link = (@feed/:channel/:link).text
      
      return nil if not link or link == ''
      return link
    end
    
    def description
      description = (@feed/:channel/:description).text
      
      return nil if not description or description == ''
      return description
    end
    
    def casts
      casts = []
      (@feed/:channel/:item).each do |item|
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
