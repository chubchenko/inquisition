module Inquisition
  module Core
    module Presenters
      module Pages
        module Html
          class IndexPagePresenter < HtmlPagePresenter
            def database_adapter
              Data::Database::DatabaseAdapterPresenter.instance.call
            end

            def ruby_version
              Data::Common::RubyVersionPresenter.instance.call
            end

            def rails_version
              Data::Common::RailsVersionPresenter.instance.call
            end

            def quantity_of_gems
              Data::Common::QuantityOfGemsPresenter.instance.call
            end

            def git_existence?
              Data::Common::GitExistencePresenter.instance.call
            end

            def js_runtime_version
              Data::Common::JavascriptRuntimeVersionPresenter.instance.call
            end

            def files_summary_table
              Elements::Html::Static::Table::FilesSummaryTablePresenter.instance.call
            end

            def auditors_list
              Elements::Html::Static::List::AuditorsListPresenter.instance.call
            end

            def table_with_routes
              Elements::Html::Static::Table::RoutesTablePresenter.instance.call
            end

            def route_methods_chart
              Elements::Html::Static::Chart::RouteMethodsChartPresenter.instance.call
            end

            def errors_count_chart
              Elements::Html::Static::Chart::ErrorsCountChartPresenter.instance.call
            end

            def issues_with_solutions_pipeline
              Elements::Html::Static::Pipeline::IssuesWithSolutionsPipelinePresenter.instance.call
            end

            def hottest_issues
              Elements::Html::Static::Pipeline::HottestIssuesPipelinePresenter.instance.call
            end
          end
        end
      end
    end
  end
end
