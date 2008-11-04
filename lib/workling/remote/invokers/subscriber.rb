require 'workling/remote/invokers/base'

#
#  Subscribes the workers to the correct queues. 
#
#  FIXME: remove EM loop from this class. EM is Amqp-Specifc, 
#  so it needs to be moved into the AMQPClient class. 
# 
module Workling
  module Remote
    module Invokers
      class Subscriber < Workling::Remote::Invokers::Base
        
        def initialize(routing, client_class)
          @routing = routing
          @client_class = client_class
        end
        
        #
        #  Starts EM loop and sets up subscription callbacks for workers. 
        #
        def listen
          EM.run do
            @routing.queue_names_routing_class(clazz).each do |queue|
              handler = @routing[queue]
              method_name = @routing.method_name(queue)

              @client.subscribe(queue) do
                handler.dispatch_to_worker_method(method_name, result)
              end
            end
          end
        end
        
        #
        #  Stops the EM loop
        #
        def stop
          Em.stop
        end
      end
    end
  end
end