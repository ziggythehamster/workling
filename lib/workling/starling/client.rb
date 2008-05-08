module Workling
  module Starling
    class Client
      cattr_accessor :starling_url
      cattr_accessor :connection
      
      def initialize
        self.class.read_config unless self.class.connection
      end
      
      def self.read_config
        memcache_options = YAML.load( IO.read(::RAILS_ROOT + "/config/starling.yml") )[::RAILS_ENV].symbolize_keys
        self.starling_url = memcache_options.delete(:listens_on)
        self.connection = ::MemCache.new(self.starling_url, memcache_options)
      end
      
      def method_missing(method, *args)
        self.class.connection.send(method, *args)
      end
    end
  end
end