require 'capybara/dsl'
require_relative '../extensions/control_chain_methods'

module Controls
  module Main
    # The search control on the main page
    class SearchControl
      extend Capybara::DSL
      extend Extensions::ControlChainMethods

      CONTROL_SELECTOR = '#header #searchbox'.freeze

      class << self
        # @return [Boolean] Indicates if the control is visible.
        def visible?
          page.all(CONTROL_SELECTOR, wait: 10).any?
        end

        # Submits the control with the given text
        #
        # @param text [String]
        def search(text)
          page.within(CONTROL_SELECTOR, wait: 5) do
            first('input.search_query').set(text)
            first('button.button-search').click
          end
        end
      end
    end
  end
end