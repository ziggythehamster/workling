require 'workling/clients/base'

module Workling
  module Clients
    class MemoryQueue < Workling::Clients::Base
      def connect; nil; end
      def request(work_type, arguments); nil; end
      def retrieve(work_uid); nil; end
    end
  end
end