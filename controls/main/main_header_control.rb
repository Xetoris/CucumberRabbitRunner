require_relative '../shared/base_control'

module CucumberRabbitRunner
  module Controls
    module Main
      # Represents the main page's header.
      class MainHeaderControl
        include Controls::Shared::BaseControl

        def initialize
          super('#header')
        end
      end
    end
  end
end