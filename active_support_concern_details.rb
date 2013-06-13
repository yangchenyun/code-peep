# GistID: 4245473
# Examine how ActiveSupport works
# https://github.com/rails/rails/blob/master/activesupport/lib/active_support/concern.rb#L110
require 'active_support/concern'

module Foo
  # @_dependencies is set to [] within Foo
  # new class methods append_features and included is added to Foo
  # they are triggered later by Bar
  extend ActiveSupport::Concern

  # included is the hijacked methods from ActiveSupport::Concern
  # @_included_block is set to the class_eval block
  included do
    class_eval do
      def self.method_injected_by_foo
        # ...
      end
    end
  end
end

module Bar
  # @_dependencies is set to [] within Bar
  # new class methods append_features and included is added to Bar
  # they are triggered later by Host
  extend ActiveSupport::Concern

  # trigger the Foo.append_features(Bar)
  # Bar.@_dependencies = [Foo]
  include Foo

  # Bar.@_included_block
  included do
    self.method_injected_by_foo
  end
end

class Host
  # trigger Bar.append_features(Host)
  # Host is not a concern and Host is not subclass of Bar
  # Bar.@_dependencies is evaluated with Host.send(:include, Foo)
  # trigger Foo.append_features(Host), included at the base of Host
  #
    # into the Foo context
    # no dependencies needed to be resolved
    # implement default Ruby behavior - copy constants, methods and module variables
    # Host.extend the ClassMethods modules if any
    # Host.class_eval the Foo.@_included_block
  #
  # back to the Bar context
  # implement default Ruby behavior - copy constants, methods and module variables
  # Host.extend ClassMethods
  # Host.class_eval the @_included_block
  include Bar
end
