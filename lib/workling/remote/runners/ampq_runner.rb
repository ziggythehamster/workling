require 'workling/remote/runners/base'

#
#  Runs Jobs over an AMQP enabled broker such as RabbitMQ. See the README for full instructions.
#
module Workling
  module Remote
    module Runners
      class AmpqRunner < Workling::Remote::Runners::Base
        cattr_accessor :routing
        
        def initialize
          AmpqRunner.routing = Workling::Routing::ClassAndMethodRouting.new
          AmpqRunner.client = Workling::Clients::AmqpClient.new
        end
        
        # enqueues the job onto RabbitMQ or similar
        def run(clazz, method, options = {})
          AmqpClient.client.set(@@routing.queue_for(clazz, method), options)    
          
          return nil
        end
      end
    end
  end
end