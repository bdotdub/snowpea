require 'sinatra/lib/sinatra.rb'
require 'rubygems'

Sinatra::Application.default_options.merge!(
   :run => false,
   :env => :production,
   :raise_errors => true,
   :root => File.dirname(__FILE__)
   :views => File.dirname(__FILE__) + '/views'
)

log = File.new("logs/access", "a")
STDOUT.reopen(log)
errlog = File.new("logs/error", "a")
STDERR.reopen(errlog)
      
require 'snowpea.rb'
run Sinatra.application

