require 'workling/starling/routing/base'

module Workling
  module Starling
    module Routing
      class ClassAndMethodRouting < Base
        
        def method_name(queue)
          queue.split("__").last
        end
        
        def queue_for(clazz, method)
          self.class.queue_for(clazz, method)
        end
        
        def self.queue_for(clazz, method)
          "#{ clazz.to_s.tableize }/#{ method }".split("/").join("__") # Don't split with : because it messes up memcache stats
        end
        
        # NOTE dave dupre, 07.06.08
        # Updated the way ClassAndMethodRouting builds the routing hash. I needed a routing hash per worker. 
        # Note, whatever you do don’t ever try to call routing.build from inside another thread. 
        # Really strange things happen that were very difficult to track down.
        #
        # Call this for each worker class to set it up and determine all the queues
        def build(clazz)

          # Tell each worker class you are about to create it. This will allow for worker init.
          worker = clazz.new
          worker.create if worker.respond_to?('create')

          # Set up the queues for this class
          routing = self.class.new
          methods = clazz.instance_methods(false)
          methods.each do |method|
            next if method == 'create'  # Skip the create method
            queue =  queue_for(clazz, method)
            routing[queue] = clazz.new
          end
          
          return routing
        end
        
      end
    end
  end
end