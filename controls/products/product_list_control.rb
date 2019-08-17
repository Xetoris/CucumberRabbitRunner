require 'capybara/dsl'
require_relative '../extensions/control_chain_methods'

module Controls
  module Products
    # List of product category results.
    class ProductListControl
      extend Capybara::DSL
      extend Extensions::ControlChainMethods

      CONTROL_SELECTOR = 'ul.product_list'.freeze

      class << self

        # Views the details for a random product in the results list.
        def view_random_product
          page.all("#{CONTROL_SELECTOR} .product-container .product_img_link").sample.click
        end

        # Indicates if the control is displaying any results.
        #
        # @param min [Integer] Minimum number of results that should be displayed. Optional. Default: 1
        def results?(min: 1)
          has_selector?("#{CONTROL_SELECTOR} .product-container", wait: 5, minimum: min)
        end

        # @return [Boolean] Indicates if the control is visible.
        def visible?
          page.all(CONTROL_SELECTOR, wait: 10).any?
        end
      end
    end
  end
end