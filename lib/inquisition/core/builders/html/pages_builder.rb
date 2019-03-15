module Inquisition
  module Core
    module Builders
      module Html
        class PagesBuilder < Core::Builders::BaseHtmlBuilder
          PAGE_BUILDERS = {
            index: IndexPageBuilder,
            database_summary: DatabaseSummaryPageBuilder
          }.freeze

          def call
            build_pages
          end

          private

          def build_pages
            PAGE_BUILDERS.map do |page, builder|
              {
                name: page,
                content: builder.new(@auditors_tree).call
              }
            end
          end

          # def include_path?(path)
          #   BaseConfig.config_enabled?(:linters, path)
          # end
        end
      end
    end
  end
end
