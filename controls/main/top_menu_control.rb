require 'capybara/dsl'
require_relative '../extensions/control_chain_methods'

module Controls
  module Main
    # Top Navigation control.
    class TopMenuControl
      extend Capybara::DSL
      extend Extensions::ControlChainMethods

      CONTROL_SELECTOR = '#block_top_menu'.freeze

      class << self

        # Clicks the dresses link
        def view_dresses
          find("#{CONTROL_SELECTOR} a", text: /dresses/i, wait: 5).click
        end

        # @return [Boolean] Indicates if the control is visible.
        def visible?
          page.all(CONTROL_SELECTOR, wait: 5).any?
        end
      end
    end
  end
end