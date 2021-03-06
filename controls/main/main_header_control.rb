require 'capybara/dsl'
require_relative '../extensions/control_chain_methods'

module Controls
  module Main
    # Represents the main page's header.
    class MainHeaderControl
      extend Capybara::DSL
      extend Extensions::ControlChainMethods

      class << self
        # @return [Boolean] Indicates if the control is visible.
        def visible?
          page.all('#header', wait: 10).any?
        end
      end
    end
  end
end