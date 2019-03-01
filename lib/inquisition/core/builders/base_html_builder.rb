require 'tilt/haml'
require 'launchy'

module Inquisition
  module Core
    module Builders
      class BaseHtmlBuilder < Core::BaseBuilder
        BASE_ENGINE = Tilt::HamlTemplate

        def call
          build_page
        end

        def ruby_version
          RUBY_VERSION
        end

        def menu_items
          Core::Presenters::MenuItemsPresenter.new.call
        end

        private

        def build_page
          output = render_page
          save_rendered_page(output)
          open_page
        end

        def render_page
          BASE_ENGINE.new(File.join(Inquisition.root, child_class::TEMPLATE_PATH)).render(self)
        end

        def save_rendered_page(output)
          File.open(File.join(Inquisition.root, child_class::OUTPUT_FILE), 'w') { |file| file.write(output) }
        end

        def open_page
          Launchy.open(File.join(Inquisition.root, child_class::OUTPUT_FILE)) do |exception|
            puts "Attempted to open #{child_class::BASE_OUTPUT_FILE} and failed because #{exception}"
          end
        end

        def child_class
          self.class
        end
      end
    end
  end
end
