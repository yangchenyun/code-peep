# this will load the filename as absolute path
if gem_original_require '/tmp/des'
  puts "loaded /tmp/des.rb"
end

# this will search $LOAD_PATH to load erb.rb
if gem_original_require 'erb'
  puts "loaded erb.rb"
end

gem_original_require '/tmp/des'
# is the same as
gem_original_require '/tmp/des.rb'
# or if any
# gem_original_require '/tmp/des.so'

# so are these
gem_original_require 'erb'
gem_original_require 'erb.rb'
# gem_original_require 'erb.so'

# Demo: absolute path | searched in $LOADED_PATH is exclusive
# gem_original_require './erb.rb'
# => cannot load such file -- ./erb.rb (LoadError)
gem_original_require 'erb.rb'
# => it will be searched in the directories listed in $LOAD_PATH
# => true

# in a.rb
# gem_original_require 'b'
# cannot load such file -- b (LoadError)
gem_original_require './b'
# true

# Given this tree
# ├── a.rb
# ├── b.rb
# └── sub
    # └── c.rb

# use $LOADED_FEATURES internally
# use absolute path
$LOADED_FEATURES << './sub/c.rb'
# will no be loaded
gem_original_require './sub/c'
