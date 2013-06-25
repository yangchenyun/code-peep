# http://khakimov.com/blog/2012/05/11/back-to-school-linked-list-with-ruby/

Cell = Struct.new(:value, :next)

list = Cell.new('head', nil)

def link_list(value, cell)
  return Cell.new(value, cell)
end

def recursion_print(list)
  p list.value
  recursion_print(list.next) unless list.next.nil?
end

# i = 0
# 10.times do
#   i += 1
#   list = link_list(i, list)
# end
# recursion_print(list)

def bench type
  t1 = Time.now
  yield
  t2 = Time.now
  p "#{type} used #{t2 - t1} seconds"
end

ary = []
list = Cell.new('head', nil)

bench('array') do
  100_000.times { ary.insert 0, 10 }
end

bench('linked_list') do
  100_000.times { list = link_list(10, list) }
end
