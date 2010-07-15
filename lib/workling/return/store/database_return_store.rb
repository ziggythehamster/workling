require 'workling/return/store/base'

#
#  Kai De Sutter Stores directly into db
#
module Workling
  module Return
    module Store
      class DatabaseReturnStore < Base

        def initialize
          
        end

        def set(key, value)
          store = ReturnStore.find_by_key(key)
          store = ReturnStore.new({:key => key}) if store.nil?
          store.value = value
          store.save
        end

        def get(key)
          store = ReturnStore.find_by_key(key)
          value = store.value
          store.destroy
          return value
        end
      end
    end
  end
end