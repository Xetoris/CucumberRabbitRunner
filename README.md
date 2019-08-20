# CucumberRabbitRunner
Demonstrates using RabbitMQ to create a test runner for Cucumber.

-- Steps to get started

Launch Rabbit:

docker run -d --hostname my-rabbit --name some-rabbit -p 8080:15672 -p 8081:5672 rabbitmq:3-management

Set Environment Variables:

| Variable | Value |
|---|---|
| RABBIT_HOST | 127.0.01 |
| RABBIT_USER | guest |
| RABBIT_PASS | guest |

From CMD/Shell:
```
bundle exec ruby ./bin/rabbit_boot.rb
```

To queue messages:
```
cucumber --dry-run
```
