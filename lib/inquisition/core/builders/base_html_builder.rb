require 'tilt/haml'

module Inquisition
  module Core
    module Builders
      class BaseHtmlBuilder < Core::BaseBuilder
        BASE_ENGINE = Tilt::HamlTemplate

        def call
          build_page
        end

        private

        def build_page
          BASE_ENGINE.new(template).render(presenter)
        end

        def template
          File.join(Inquisition.root, child_class::TEMPLATE_PATH)
        end

        def presenter
          child_class::PAGE_PRESENTER.new(@auditors_tree)
        end

        def child_class
          self.class
        end
      end
    end
  end
end
