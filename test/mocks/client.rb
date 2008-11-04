require 'workling/clients/base'

module Workling
  module Clients
    class MemcacheQueue < Workling::Clients::Base
      def raise_unless_connected!; end
    end
  end
end