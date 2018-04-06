module CucumberRabbitRunner
  module EventListeners
    # Our Cucumber event listener, which queues a message when invoked.
    class RabbitQueueListener
      # Creates a new instance with the given connection information.
      #
      # @param config [Cucumber::Configuration] The configuration object from Cucumber.
      def initialize(config)
        return unless config.dry_run?

        config.on_event :test_case_finished, &method(:after_test_case)
      end

      # Handles the after test case event for this auditor.
      #
      # @param event [Cucumber::Events::TestCaseFinished] The data from the event.
      def after_test_case(event)
        
      end
    end
  end
end