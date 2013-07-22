#
# $Id: semaphore.rb,v 1.2 2003/03/15 20:10:10 fukumoto Exp $
#

class CountingSemaphore
  attr_accessor :counter, :waiting_list

  def initialize(initvalue = 0)
    # @counter is shared across multiple threads
    # how to guarantee its exclusiveness
    @counter = initvalue
    @waiting_list = []
  end

  def wait
    # Thread.critical = true
    if (@counter -= 1) < 0
      @waiting_list.push(Thread.current)
      puts "#{Thread.current} is put to wait_list"
      Thread.stop
    end
    self
  ensure
    # Thread.critical = false
  end

  def signal
    # Thread.critical = true
    begin
      if (@counter += 1) <= 0
        t = @waiting_list.shift
        puts "#{t} is shift from wait_list"
        puts t.status
        t.wakeup if t
      end
    rescue ThreadError
      retry
    end
    self
  ensure
    # Thread.critical = false
  end

  alias down wait
  alias up signal
  alias P wait
  alias V signal

  def exclusive
    wait
    yield
  ensure
    signal
  end

  alias synchronize exclusive

end

Semaphore = CountingSemaphore
