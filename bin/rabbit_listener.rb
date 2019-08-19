require_relative '../messages/file_line_command'
require_relative '../utility/rabbit_client'

module CucumberRabbitRunner
  # Contains method for listening to RabbitMQ.
  module RabbitListener
    class << self
      def handle_messages
        CucumberRabbitRunner::Utility::RabbitClient.subscribe  do |message|
          begin
            system('cucumber', get_file_part(message.folder_path,
                                             message.file_name,
                                             message.file_line_number))

          rescue StandardError => e
            puts('Something happened trying to run command.\n---')
            puts(e.message)
          end
        end
      end

      # Builds the feature target path from its components
      #
      # @param path [String] Relative path to the directory that contains the file.
      # @param file_name [String] Name of the feature file.
      # @param number [Integer] Line number in the feature file.
      def get_file_part(path, file_name, number)
        part = ''

        if /[a-zA-Z]:\// =~ path || /\.\//
          part << path
        else
          part << "./#{path}"
        end

        unless path.end_with?('/')
          part << '/'
        end

        "#{part}#{file_name}:#{number}"
      end

    end
  end
end
