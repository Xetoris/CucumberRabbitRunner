require 'capybara/dsl'
require 'rspec/matchers'

require_relative '../extensions/control_chain_methods'

module Controls
  module Products
    class ProductDetailControl
      extend Capybara::DSL
      extend RSpec::Matchers
      extend Extensions::ControlChainMethods

      CONTROL_SELECTOR = '#product'.freeze

      class << self

        # Indicates if the expected product elements are present.
        #
        # @return [Boolean]
        def has_product_details?
          page.has_css?("#{CONTROL_SELECTOR} .primary_block [itemprop='name']") &&
          page.has_css?("#{CONTROL_SELECTOR} #product_condition") &&
          page.has_css?("#{CONTROL_SELECTOR} #short_description_block") &&
          page.has_css?("#{CONTROL_SELECTOR} #bigpic")
        end

        # @return [Boolean] Indicates if the control is visible.
        def visible?
          page.all(CONTROL_SELECTOR, wait: 5).any?
        end
      end
    end
  end
end