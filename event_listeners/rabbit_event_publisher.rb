require_relative '../messages/file_line_command'
require_relative '../utility/rabbit_client'

module CucumberRabbitRunner
  module EventListeners
    # Our Cucumber event listener, which queues a message when invoked.
    class RabbitEventPublisher
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
        location = event.test_case.location.to_s.split('CucumberRabbitRunner').last
        message = CucumberRabbitRunner::Messages::FileLineCommand.new

        regex = %r{(.*/)(.*).feature:(\d*)}i
        matches = regex.match(location).captures

        message.file_line_number = matches[2]
        message.file_name = "#{matches[1]}.feature"
        message.folder_path = matches[0]

        CucumberRabbitRunner::Utility::RabbitClient.publish(message)
      end
    end
  end
end