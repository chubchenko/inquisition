module Inquisition
  module Core
    module Presenters
      module Pages
        class DatabaseSummaryPagePresenter < PagePresenter
          attr_reader :presenter

          def initialize(auditors_tree)
            @presenter = Core::Presenters::DatabaseLintersPresenter.new(auditors_tree)
            super
          end

          # def database_tables_count
          # @database_presenter.tables_count
          # end

          # def database_errors_count
          # @database_presenter.total_errors
          # end

          # def included_linters_count
          # @database_presenter.included_linters_count
          # end

          # def repeated_indexes_percentage
          # @database_presenter.repeated_indexes_percentage
          # end
        end
      end
    end
  end
end
