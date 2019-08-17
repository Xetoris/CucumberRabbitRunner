require 'bunny'
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
      queue = queue('FileRunCommand')
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

    # Returns an instance of [Bunny::Queue] based on the queue name.
    #
    # @param name [Symbol]
    #
    # @return [Bunny::Queue]
    def queue(name)
      unless @queue
        channel = bunny_client.create_channel
        channel.prefetch(1)
        @queue = channel.queue("QE.#{name}.Queue")
       end

      @queue
    end

    # @return [Bunny::Client] Our instance of the Bunny Rabbit client.
    def bunny_client
      unless @client
        @client ||= Bunny.new( { host: ENV['RABBIT_HOST'],
                                 user: ENV['RABBIT_USER'],
                                 pass: ENV['RABBIT_PASS'],
                                 port: 8081 })

        @client.start
      end

      @client
    end
  end
end
