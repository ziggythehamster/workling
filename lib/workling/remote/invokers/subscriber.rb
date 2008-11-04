#
#  Subscribes the workers to the correct queues. 
# 
module Workling
  module Remote
    module Invokers
      class Subscriber
        
        def initialize(routing, client)
          @routing = routing
          @client_class = client
          
          listen
        end
        
        private
          def listen
            @routing.queue_names_routing_class(clazz).each do |queue|
              handler = @routing[queue]
              method_name = @routing.method_name(queue)
              
              @client.subscribe(queue) do
                handler.dispatch_to_worker_method(method_name, result)
              end
            end
          end
      end
    end
  end
end