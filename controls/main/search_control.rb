require_relative '../shared/base_control'

module CucumberRabbitRunner
  module Controls
    module Main
      # The search control on the main page
      class SearchControl
        include Controls::Shared::BaseControl

        def initialize
          super('#header #searchbox')
        end

        # Submits the control with the given text
        #
        # @param text [String]
        def search(text)
          within(control) do
            first('input.search_query').set(text)
            first('button.button-search').click
          end
        end
      end
    end
  end
end