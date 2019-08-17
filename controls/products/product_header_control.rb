require 'capybara/dsl'
require_relative '../extensions/control_chain_methods'

module Controls
  module Products
    # Control for the top header portion of product list
    class ProductHeaderControl
      extend Capybara::DSL
      extend Extensions::ControlChainMethods

      CONTROL_SELECTOR = '.content_scene_cat'.freeze

      class << self
        # Indicates if the header currently matches specified category
        #
        # @param category_name [String] Title of the category to check against.
        #
        # @return [Boolean]
        def matches_category?(category_name: )
          raise('Cannot check a missing or empty category name!') unless category_name && !category_name.empty?

          regex = /#{category_name}/i
          image_match = has_selector?("#{CONTROL_SELECTOR} .category-name", text: regex)
          title_match = has_selector?('.page-heading.product-listing .cat-name', text: regex)

          image_match && title_match
        end

        # @return [Boolean] Indicates if the control is visible.
        def visible?
          page.all(CONTROL_SELECTOR, wait: 5).any?
        end
      end
    end
  end
end