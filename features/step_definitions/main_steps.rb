Then(/(?:He|She) sees the landing page/) do
  CucumberRabbitRunner::Controls::Main::MainHeaderControl.new.assert_visible
end