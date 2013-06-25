# Under a "private" call, class methods are not real private methods,
# they're public just like any other method.
class A
  private
  def self.some_secret
    puts 'this is seen.'
  end
end

A.some_secret
# this is seen.

class B
  def self.some_secret
    puts 'not seen.'
  end

  private_class_method :some_secret
end

B.some_secret
# NoMethodError: private method `some_secret' called for B:Class
