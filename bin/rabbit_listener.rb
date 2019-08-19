require_relative '../messages/file_line_command'

module CucumberRabbitRunner
  # Contains method for listening to RabbitMQ.
  class RabbitListener
    # Subscribes to the queue for the given message's class.
    #
    # for block { |message| ... }
    # @yield [message] Invokes the block passing a populated instance of the message type received.
    #    If the block finishes without error, the message will be acknowledged and removed from queue.
    #
    # @yieldparam [#from_json_string] message The populated instance of the message received.
    def subscribe
      queue = CucumberRabbitRunner::Utility::RabbitClient.queue
      queue.subscribe(manual_ack: true) do |info, _meta, data|
        begin
          message = CucumberRabbitRunner::Messages::FileLineCommand.from_json(data)

          yield message

          queue.channel.acknowledge(info.delivery_tag)
        rescue StandardError => e
          puts("Something happened processing this message.\n Exception: #{e.message}")
        end
      end
    end
  end
end
