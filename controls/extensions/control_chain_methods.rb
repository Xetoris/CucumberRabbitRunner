require 'rspec/matchers'

module Controls
  module Extensions
    # Module for some common methods we want to chain off of.
    module ControlChainMethods
      extend RSpec::Matchers

      # Asserts that visible? returns true before continuing.
      #
      # @return [Object] The control we're manipulating.
      def assert_visible
        raise('Cannot use ControlChainMethods#assert_visible on control with no #visible? method') unless respond_to?(:visible?)

        expect(visible?).to be_truthy

        self
      end

      class << self
        # Method fired when we include this module.
        #   Adds RSpec Matchers dependency.
        #
        # @param mod [Class, Module]
        def included(mod)
          mod.include(RSpec::Matchers)
        end

        # Method fired when we extend with this module.
        #   Adds RSpec Matchers dependency.
        #
        # @param mod [Class, Module]
        def extended(mod)
          mod.extend(RSpec::Matchers)
        end
      end
    end
  end
end