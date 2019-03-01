module Inquisition
  module Core
    module Outputers
      class HtmlOutputer < BaseOutputer
        def call
          build_wellcome_page
        end

        private

        def build_wellcome_page
          Core::Builders::Html::WellcomePageBuilder.new(@auditors_tree).call
        end
      end
    end
  end
end
