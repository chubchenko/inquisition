module Inquisition
  module Core
    module Presenters
      module Pages
        class DatabaseSummaryPagePresenter < PagePresenter
          def_delegators :@database_presenter, :tables_count, :total_errors, :top_types_of_errors
          def_delegators :@database_presenter, :included_linters_count, :repeated_indexes_percentage
          def_delegators :@database_presenter, :missing_foreign_keys_percentage, :top_tables_with_errors
          def_delegators :@database_presenter, :incompatibility_structure_with_models_percentage
          def_delegators :@database_presenter, :unindexed_foreign_keys_percentage
          def_delegators :@migration_presenter, :total_migrations, :schema_version
          def_delegators :@rails_about_presenter, :database_adapter

          def initialize(auditors_tree)
            @database_presenter = Core::Presenters::DatabaseLintersPresenter.new(auditors_tree)
            @migration_presenter = Core::Presenters::MigrationPresenter.new
            @rails_about_presenter = Core::Presenters::RailsAboutPresenter.new
            super
          end
        end
      end
    end
  end
end
