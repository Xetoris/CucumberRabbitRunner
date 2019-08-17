And(/^(?:.*) sees several listings for (?:.*)$/) do
  expect(Controls::Products::ProductListControl.assert_visible.results?(min: 3))
end

Then(/^(?:.*) sees at least one result$/) do
  expect(Controls::Products::ProductListControl.assert_visible.results?(min: 1))
end

And(/^(?:.*) view the details for the first (?:.*)$/) do
  Controls::Products::ProductListControl.view_random_product
end

Then(/^(?:.*) sees the (?:.*) details$/) do
  expect(Controls::Products::ProductDetailControl.assert_visible.has_product_details?).to be_truthy
end