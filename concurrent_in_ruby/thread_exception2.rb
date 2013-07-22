require 'thread'

t = Thread.new do
  print "Enter the thread\n"
  raise StandardError, 'something goes wrong'
  print "this is not executed"
end

# If a thread t exits because of an unhandled exception,
# and another thread s calls t.join or t.value,
# then the exception that occurred in t is raised in the thread s.

begin
  t.value
  # t.join
rescue => e
  puts "#{e.class}, #{e} is rescued"
end
