# GistID: 4245473
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

  # trigger the Foo.append_features
  # @_dependencies = [Foo]
  include Foo

  included do
    self.method_injected_by_foo
  end
end

class Host
  # trigger the Bar.append_features(base = Host)
  # base.send(:include, Foo)
  # normal Ruby behavior to mixin the methods
  # base.extend ClassMethods
  # base.class_eval the @_included_block
  include Bar
end
