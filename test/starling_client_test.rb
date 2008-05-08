require File.dirname(__FILE__) + '/test_helper'

context "The starling client" do
  specify "should load it's config with MemCache options from RAILS_ENV/config/starling.yml" do
    client = Workling::Starling::Client.new
    client.starling_url.should.equal "localhost:22122"
    client.connection.servers.first.host.should == "localhost"
    client.connection.servers.first.port.should == 22122    
    client.connection.namespace.should.equal "myapp_development"
  end
end