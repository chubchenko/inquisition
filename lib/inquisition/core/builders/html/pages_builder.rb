module Inquisition
  module Core
    module Builders
      module Html
        class PagesBuilder < Core::Builders::BaseHtmlBuilder
          PAGE_BUILDERS = {
            index: IndexPageBuilder,
            database_summary: DatabaseSummaryPageBuilder,
            hottest_issues: HottestIssuesPageBuilder,
            issues_and_solutions: IssuesAndSolutionsPageBuilder
          }.freeze

          def call
            build_pages
          end

          private

          def build_pages
            pages.map do |page_name, builder|
              {
                name: page_name,
                content: builder.new.call(page_name)
              }
            end
          end

          def pages
            prepared_pages.select(&method(:only_included_pages))
          end

          def prepared_pages
            common_pages_hash = common_pages.inject(:merge) || {}
            PAGE_BUILDERS.merge(common_pages_hash)
          end

          def only_included_pages(page, _builder)
            custom_page?(page) || auditor_enabled?(page)
          end

          def custom_page?(page)
            auditors_list.none?(page)
          end

          def common_pages
            builded_pages.map do |page|
              {
                page => CommonPageBuilder
              }
            end
          end

          def builded_pages
            auditors_list - PAGE_BUILDERS.keys
          end
        end
      end
    end
  end
end
