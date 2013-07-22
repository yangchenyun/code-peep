require 'thread'

mutex = Mutex.new
resource = ConditionVariable.new
data_ready = false
data = nil

producer = Thread.new do
  print "In producer thread...\n"
  loop do
    mutex.synchronize do
      # if the data is not processed
      # wait for consumer to process it
      while data_ready do
        # release the lock and wait
        resource.wait(mutex)
      end
      data = gets
      data_ready = true
      print "producer:  got data from STDIN\n"
      resource.broadcast
    end
  end
end

consumer1 = Thread.new do
  print "In consumer1 thread...\n"
  loop do
    mutex.synchronize do
      until data_ready do
        # release the lock and wait
        resource.wait(mutex)
      end
      print "consumer1:  wake up by producer\n"
      print "the data is #{data}"
      data_ready = false
      resource.signal
    end
  end
end

consumer2 = Thread.new do
  print "In consumer2 thread...\n"
  loop do
    mutex.synchronize do
      until data_ready do
        # release the lock and wait
        resource.wait(mutex)
      end
      print "consumer2:  wake up by producer\n"
      print "the data is #{data}"
      data_ready = false
      resource.signal
    end
  end
end

[producer, consumer1, consumer2].map(&:join)
