#
#  Invokers are responsible for 
#
#      1. grabbing work off a job broker (such as a starling or rabbitmq server)
#      2. routing (mapping) that work onto the correct worker method
#      3.invoking the worker method, passing any arguments that came off the broker.
#
#   Invokers should implement their own concurrency strategies. For example, 
#   The there is an Invoker implementation which starts a thread for each Worker
#   class. 
#
#   This base Invoker class defines the methods an Invoker needs to implement. 
#  
module Workling
  module Remote
    module Invokers
      class Base
        
        #
        #  Starts main Invoker Loop. The invoker runs until stop() is called. 
        #
        def listen
          raise NotImplementedError.new("Implement listen() in your Invoker. ")
        end        
        
        #
        #  Gracefully stops the Invoker. The currently executing Jobs should be allowed
        #  to finish. 
        #
        def stop
          raise NotImplementedError.new("Implement stop() in your Invoker. ")
        end
        
        # returns the Workling::Base.logger
        def logger; Workling::Base.logger; end
        
      end
    end
  end
end