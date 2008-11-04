require 'workling/clients/base'
require 'mq'

#
#  An Ampq client
#
module Workling
  module Clients
    class AmqpClient < Workling::Clients::Base

      # connects to the queue server
      def connect
        @amq = MQ.new
      end
      
      # disconnect from the queue server
      def close
        @amq.close
      end

      # subscribe to a queue
      def subscribe(key)
        @amq.queue(key).subscribe do |value|
          yield value
        end
      end

      def get(key)
        @amq.queue(key)
      end

      def set(key, value)
        @amq.queue(key).publish(value)
      end
    end
  end
end