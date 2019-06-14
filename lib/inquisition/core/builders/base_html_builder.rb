module Inquisition
  module Core
    module Builders
      class BaseHtmlBuilder < Core::BaseBuilder
        include Helpers::AuditorsHelper
        attr_reader :page_name

        PAGE_LAYOUT = 'layouts/page_layout.html.haml'.freeze

        def call(page_name)
          @page_name = page_name
          build_page
        end

        private

        def build_page
          render_with_layout do
            Outputers::HtmlOutputer::BASE_ENGINE.new(template).render(presenter)
          end
        end

        def render_with_layout
          Outputers::HtmlOutputer::BASE_ENGINE.new(layout).render(presenter) { yield if block_given? }
        end

        def template
          File.join(Inquisition.root, Outputers::HtmlOutputer::TEMPLATE_PATH, child_class::TEMPLATE)
        end

        def layout
          File.join(Inquisition.root, Outputers::HtmlOutputer::TEMPLATE_PATH, PAGE_LAYOUT)
        end

        def presenter
          child_class::PAGE_PRESENTER.new(page_name)
        end

        def child_class
          self.class
        end
      end
    end
  end
end
