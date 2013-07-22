require 'thread'

Thread.new do
  print "Enter the thread\n"
  raise StandardError, 'something goes wrong'
  print "this is not executed\n"
end

Thread.new do
  print "Enter another thread\n"
  print "this might be aborted as a global effect.\n"
end

# when set Thread.abort_on_exception to true (default to false)
# any unhandled exception in any thread to cause the interpreter to exit,
Thread.abort_on_exception = true

sleep(1)
