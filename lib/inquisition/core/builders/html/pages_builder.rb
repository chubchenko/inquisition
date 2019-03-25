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

          PAGE_GUARD = {
            lol_dba: %i[backend lol_dba],
            active_record_doctor: %i[backend active_record_doctor],
            rails_best_practices: %i[backend rails_best_practices],
            reek: %i[backend reek],
            rubocop: %i[backend rubocop],
            ruby_lint: %i[backend ruby_lint],
            yamllint: %i[backend yamllint],
            rspec_rubocop: %i[backend rspec_rubocop],
            fasterer: %i[backend fasterer],
            bullet: %i[backend bullet],
            bundler_audit: %i[backend bundler_audit],
            brakeman: %i[backend brakeman],
            dawnscanner: %i[backend dawnscanner],
            traceroute: %i[backend traceroute],
            diagrams: %i[backend railsroady],
            erd: %i[backend erd]
          }.freeze

          COMMON_PAGES = %i[
            lol_dba
            active_record_doctor
            rails_best_practices
            reek
            rubocop
            ruby_lint
            yamllint
            rspec_rubocop
            fasterer
            bullet
            bundler_audit
            brakeman
            dawnscanner
            traceroute
            railsroady
            erd
            rspec
            simplecov
            frontend
            code_smells_summary
          ].freeze

          def call
            build_pages
          end

          private

          def build_pages
            pages.map do |page, builder|
              {
                name: page,
                content: builder.new(@auditors_tree).call(page)
              }
            end
          end

          def pages
            merged_pages.select(&method(:only_included_pages))
          end

          def merged_pages
            common_pages_hash = common_pages
            common_pages_hash.any? ? PAGE_BUILDERS.merge(common_pages_hash.inject(:merge)) : PAGE_BUILDERS
          end

          def only_included_pages(page, _builder)
            page_guard_path = PAGE_GUARD[page]
            page_guard_path ? include_path?(page_guard_path) : true
          end

          def common_pages
            (COMMON_PAGES - PAGE_BUILDERS.keys).map do |page|
              {
                page => CommonPageBuilder
              }
            end
          end

          def include_path?(path)
            BaseConfig.config_enabled?(:linters, *path)
          end
        end
      end
    end
  end
end
