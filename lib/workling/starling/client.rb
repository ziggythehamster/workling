require 'workling/starling'

module Workling
  module Starling
    class Client
      attr_accessor :starling_url
      attr_accessor :connection
      
      def initialize
        @starling_url = Workling::Starling.config[:listens_on]
        @connection = ::MemCache.new(self.starling_url, Workling::Starling.config[:memcache_options])
      end
      
      def method_missing(method, *args)
        @connection.send(method, *args)
      end
      
      def stats
        @connection.stats
      end
    end
  end
end