require 'bunny'

module CucumberRabbitRunner
  module Utility
    # Utility class for talking to RabbitMQ.
    class RabbitClient
      class << self
        # Subscribes to the queue for the given message's class.
        #
        # for block { |message| ... }
        # @yield [message] Invokes the block passing a populated instance of the message type received.
        #    If the block finishes without error, the message will be acknowledged and removed from queue.
        #
        # @yieldparam [#from_json_string] message The populated instance of the message received.
        def subscribe
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

        # Publishes our message.
        #
        # @param [CucumberRabbitRunner::Messages::FileLineCommand] message The message to publish
        def publish(message)
          queue.publish(MultiJson.dump(message.as_json))
        end

        private

        # Returns an instance of [Bunny::Queue] based on the queue name.
        #
        # @return [Bunny::Queue]
        def queue
          unless @queue
            channel = bunny_client.create_channel
            channel.prefetch(1)
            @queue = channel.queue('QE.FileRunCommand.Queue')
          end

          @queue
        end

        # @return [Bunny::Client] Our instance of the Bunny Rabbit client.
        def bunny_client
          unless @client
            @client ||= Bunny.new(host: ENV['RABBIT_HOST'],
                                  user: ENV['RABBIT_USER'],
                                  pass: ENV['RABBIT_PASS'],
                                  port: 8081)

            @client.start
          end

          @client
        end
      end
    end
  end
end