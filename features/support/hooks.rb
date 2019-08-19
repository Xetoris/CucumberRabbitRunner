AfterConfiguration do |config|
  CucumberRabbitRunner::EventListeners::RabbitQueueListener.new(config)
end