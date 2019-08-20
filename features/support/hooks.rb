AfterConfiguration do |config|
  CucumberRabbitRunner::EventListeners::RabbitEventPublisher.new(config)
end