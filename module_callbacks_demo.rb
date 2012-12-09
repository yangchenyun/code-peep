# GistID: 4245259
module TestModule
  # invoked when the module itself is extended by class
  def self.extended(base)
    puts "#{base} extended with #{self}"
  end

  # invoked when the mixined module or class is included in another module
  # see below for more information
  def append_features(base)
    puts "#{base} is appended with new features"
  end
end

module OneModule
  extend TestModule
  # OneModule now has the append_features method
  # extended from TestModule
end

module AnotherModule
  include OneModule
end
