require_relative 'rabbit_listener'

module CucumberRabbitRunner
  module Bin
    # Wrapper to start listener when loaded.
    module RabbitBoot
      class << self
        def start
          @continue = true
          CucumberRabbitRunner::RabbitListener.handle_messages

          sleep(10) while @continue
        end

        def stop
          @continue = false
        end
      end
    end
  end
end

Signal.trap('INT') do
  CucumberRabbitRunner::Bin::RabbitBoot.stop
end

CucumberRabbitRunner::Bin::RabbitBoot.start