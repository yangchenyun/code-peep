load 'person.rb', true
puts defined?(Person) ? 'Person defined' : 'Person not defined'
# Person not defined

load 'person.rb'
puts defined?(Person) ? 'Person defined' : 'Person not defined'
# Person defined
