require 'delegate'

class A
  def print_name ; puts 'in A'; end
  def method_in_a; end
end

class B
  def print_name ; puts 'in B'; end
end

# names of method to be delegated are defined by A
class Proxy < DelegateClass(A)
  def initialize
    # object to be delegated to is an instance of B
    super(B.new)
  end
end

class Proxy2 < SimpleDelegator
  def initialize
    super(B.new)
  end
end

p = Proxy.new
puts p.print_name # in B
puts p.method_in_a
# undefined method `method_in_a' for #<B:0x007f98b8463568> (NoMethodError)
