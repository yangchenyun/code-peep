require 'thread'

# unhandled exceptions in thread (other than the main thread)
# will cause the thread to stop running.
Thread.new do
  print "Enter the thread\n"
  raise StandardError, 'something goes wrong'
  print "this is not executed"
end

# other threads won't be affected
Thread.new do
  print "Enter another thread\n"
  print "this is running correcty\n"
end

# provide time for thread to run
sleep(1)
