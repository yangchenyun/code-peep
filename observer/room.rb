require "observer"

class Room
  include Observable

  def receive(message, sender)
    changed
    notify_observers(message, sender)
  end
end

class Person
  def initialize(name, room)
    @name, @room = name, room
    @transcript  = ""
    @room.add_observer(self, :record)
  end

  attr_reader :transcript, :name

  def record(message, sender)
    if sender == self
      message = "Me: #{message}\n"
    else
      message = "#{sender.name}: #{message}\n"
    end

    @transcript << message
  end

  def says(message)
    @room.receive(message, self)
  end
end

class Teacher < Person

  def initialize(name, room)
    @name, @room = name, room
    @transcript  = ""
    @room.add_observer(self)
  end

  def update(message, sender)
    if sender == self
      message = "Teacher: #{message}\n"
    else
      message = "#{sender.name}: #{message}\n"
    end

    @transcript << message
  end

end

room = Room.new

greg = Person.new("Gregory", room)
jia  = Teacher.new("Jia", room)

greg.says "Hi"
jia.says "Hello"

greg.says "Fun, huh?"
jia.says "Yeah!"

puts "= Greg's Transcript ="
puts greg.transcript + "\n"

puts "= Jia's Transcript ="
puts jia.transcript
