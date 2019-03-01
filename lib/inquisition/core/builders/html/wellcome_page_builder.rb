module Inquisition
  module Core
    module Builders
      module Html
        class WellcomePageBuilder < Core::Builders::BaseHtmlBuilder
          TEMPLATE_PATH = 'lib/inquisition/generators/html/templates/index.html.haml'.freeze
          OUTPUT_FILE = 'lib/inquisition/generators/html/public/index.html'.freeze
        end
      end
    end
  end
end
