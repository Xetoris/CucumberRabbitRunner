Then(/^(?:.*) sees the landing page$/) do
  Controls::Main::MainHeaderControl.assert_visible
end

And(/^(?:.*) views (.*) products$/) do |category|
  Controls::Main::TopMenuControl.assert_visible.view_dresses

  expect(Controls::Products::ProductHeaderControl.assert_visible.matches_category?(category_name: category)).to be_truthy
end

And(/^(?:.*) searches for "(.*)"$/) do |search_term|
  Controls::Main::SearchControl.assert_visible.search(search_term)
end