require 'thread'

count_a = count_b = count_c = 0

# th.priority= sets the priority of thr to integer.
# Higher-priority threads will run more frequently than lower-priority threads.
# But lower-priority threads can also run.

a = Thread.new do
  loop { count_a += 1 }
end
a.priority = -1

b = Thread.new do
  loop { count_b += 1 }
end
b.priority = -2

Thread.new do
  # A thread can, adjust its own priority as the first action it takes.
  Thread.current.priority = 1
  loop { count_c += 1 }
end

sleep 1
puts count_a
puts count_b
puts count_c
