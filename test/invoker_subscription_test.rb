require File.dirname(__FILE__) + '/test_helper.rb'

context "the invoker 'subscription'" do
  setup do
    routing = Workling::Routing::ClassAndMethodRouting.new
    @client = Workling::Clients::MemoryQueue.new
    @client.connect
    @invoker = Workling::Remote::Invokers::Subscriber.new(routing, @client.class)
  end
  
  xspecify "should invoke Util.echo with the arg 'hello' if the string 'hello' is set onto the queue utils__echo" do
    Util.any_instance.stubs(:echo).with("hello")
    @client.request("utils__echo", "hello")
    @invoker.dispatch!(@client, Util)
  end
  
  xspecify "should not explode when listen is called, and stop nicely when stop is called. " do
    fail
  end
end