require 'rspec/matchers'
require 'capybara/dsl'

module CucumberRabbitRunner
  module Controls
    module Shared
      # Shared methods across new type of control
      module BaseControl
        include RSpec::Matchers
        include Capybara::DSL

        # Default query parameters for retrieving our control.
        DEFAULT_QUERY_PARAMS = {wait: 5, minimum: 1}.freeze

        # @return [String] Selector string to find the base control with.
        attr_reader :selector

        # @return [Hash] Hash of query parameters supported by Capybara::Node::Finders#first
        #   @see Capybara::Node::Finders#first
        attr_reader :selector_params

        def initialize(selector = nil, params = {})
          @selector = selector
          @selector_params = DEFAULT_QUERY_PARAMS.merge(params)
        end

        # Returns the control
        #
        # @return [Capybara::Node::Element, nil]
        def control
          @control ||= first(@selector, @selector_params)
        end

        # Clears the control reference so we can get a fresh reference
        #
        # @return [BaseControl2]
        def refresh_control!
          @control = nil

          self
        end

        # Identifies if the control is currently visible.
        #
        # @return [Boolean]
        def visible?
          !control.nil?
        end

        # Asserts the control is visible.
        #
        # @raise [RSpec::Expectations::ExpectationNotMetError] Thrown if control is not visible.
        def assert_visible
          expect(visible?).to be true
        end

        # Asserts the control is visible.
        #   Used for method chaining.
        #
        # @raise [RSpec::Expectations::ExpectationNotMetError] Thrown if control is not visible.
        #
        # @return [BaseControl2]
        def assure_visible
          assert_visible

          self
        end
      end
    end
  end
end