begin
  gem 'fiveruns-memcache-client'
rescue
  gem 'memcache-client'
end

require 'memcache'

Workling::Discovery.discover!