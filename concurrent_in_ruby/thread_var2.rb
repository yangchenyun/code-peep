require 'thread'

# The thread object also behaves as hash, which could store thread-local variable using either a symbol or a string name
# This is handy if you need to access the local value of a thread after its life cycle
count = 0
arr = []

10.times do |i|
  arr[i] = Thread.new do
    sleep(rand(0) / 10.0)
    Thread.current['this_count'] = count
    count += 1
  end
end

arr.each { |th| th.join; print th['this_count'], ', ' }
puts "count = #{count}"
