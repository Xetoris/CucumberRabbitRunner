Then(/^.* sees the landing page$/) do
  Controls::Main::MainHeaderControl.assert_visible
end

And(/^.* attempts to view dresses listings$/) do
  Controls::Main::TopMenuControl.assert_visible.view_dresses
end