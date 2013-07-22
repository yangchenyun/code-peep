require 'thread'

mutex = Mutex.new
resource = ConditionVariable.new
data_ready = false

consumer = Thread.new do
  print "In consumer thread...\n"
  loop do
    mutex.synchronize do
      # release the lock and wait for signal
      until (data_ready) do
        resource.wait(mutex)
      end
      print "consumer:  got data from producer\n"
      data_ready = false
      resource.signal
    end
  end
end

producer = Thread.new do
  print "In producer thread...\n"
  loop do
    mutex.synchronize do
      while (data_ready) do
        resource.wait(mutex)
      end
      data_ready = true
      # release the lock and wait for signal
      resource.signal if gets
      print "producer:  got data from STDIN\n"
    end
  end
end

[consumer, producer].map(&:join)
