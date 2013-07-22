require 'thread'

# A thread can access any variables that are in scope when the thread is created.
a = 1

Thread.new do
  print "#{a}\n"
  b = 2
end

# Variables local to the block of a thread are local to the thread, and are not shared.
sleep(1)
puts b
