require 'bunny'

module CucumberRabbitRunner
  module Utility
    # Utility class for talking to RabbitMQ.
    class RabbitClient
      class << self
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

        private

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