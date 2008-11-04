#
#  An Ampq client
#
class AmqpClient
  
  def initialize
    @amq = MQ.new
  end
  
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

