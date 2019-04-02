module Inquisition
  module Core
    module Presenters
      module Pages
        module Html
          class DatabaseSummaryPagePresenter < HtmlPagePresenter
            def tables_count
              Data::Database::TablesPresenter.instance.call.count
            end

            def total_errors
              Data::Database::DatabaseTotalErrorsPresenter.instance.call
            end

            def top_types_of_errors
              Elements::Html::Static::Chart::TypesOfDatabaseErrorsChartPresenter.instance.call
            end

            def included_auditors_count
              Data::Database::IncludedAuditorsPresenter.instance.call.count
            end

            def repeated_indexes_percentage
              Elements::Html::Static::Percircle::RepeatedIndexesPercirclePresenter.instance.call
            end

            def missing_foreign_keys_percentage
              Elements::Html::Static::Percircle::MissingForeignKeysPercirclePresenter.instance.call
            end

            def incompatibility_structure_with_models_percentage
              Elements::Html::Static::Percircle::IncompatibilityStructurePercirclePresenter.instance.call
            end

            def unindexed_foreign_keys_percentage
              Elements::Html::Static::Percircle::UnindexedForeignKeysPercirclePresenter.instance.call
            end

            def top_tables_with_errors(number)
              Elements::Html::Static::LineChart::TopTablesWithErrorsLineChartPresenter.instance.call.first(number)
            end

            def total_migrations
              Data::Database::MigrationsPresenter.instance.call.count
            end

            def schema_version
              Data::Database::SchemaVersionPresenter.instance.call
            end

            def database_adapter
              Data::Database::DatabaseAdapterPresenter.instance.call
            end
          end
        end
      end
    end
  end
end
