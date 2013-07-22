require_relative "semaphore.rb"

@semaphore = Semaphore.new(1)

a = Thread.new do
  @semaphore.synchronize do
    puts "in the thread #{Thread.current}"
    sleep(5)
  end
end

b = Thread.new do
  @semaphore.synchronize do
    puts "in the thread #{Thread.current}"
    sleep(5)
  end
end

c = Thread.new do
  @semaphore.synchronize do
    puts "in the thread #{Thread.current}"
    sleep(5)
  end
end

[a, b, c].map(&:join)
