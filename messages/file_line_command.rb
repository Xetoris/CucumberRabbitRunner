require 'multi_json'

module CucumberRabbitRunner
  module Messages
    # Represents the command to run based on the file and line number.
    class FileLineCommand
      # @return [String] The file number of the scenario in the feature file.
      attr_accessor :file_line_number

      # @return [String] Name of the feature file containing the scenario.
      attr_accessor :file_name

      # @return [String] Path to the folder containing the feature file.
      attr_accessor :folder_path

      # Creates a Hash that we can run through MultiJson
      #
      # @return [Hash]
      def as_json
        { file_line_number: @file_line_number,
          file_name: @file_name,
          folder_path: @folder_path }
      end

      class << self

        # Creates a new instance from json string.
        #
        # @param json_string [String] JSON string to transform.
        #
        # @return [FileLineCommand]
        def from_json(json_string)
          hash = MultiJson.load(json_string)

          model = new

          model.file_line_number = hash['file_line_number']
          model.file_name = hash['file_name']
          model.folder_path = hash['folder_path']

          model
        end
      end
    end
  end
end