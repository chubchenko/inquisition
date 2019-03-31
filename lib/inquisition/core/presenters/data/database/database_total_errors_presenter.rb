module Inquisition
  module Core
    module Presenters
      module Data
        module Database
          class DatabaseTotalErrorsPresenter < Presenters::StaticPresenter
            private

            def build_presenter
              @build_presenter ||= auditors_data.collect(&method(:error_count_only)).compact.sum
            end

            def error_count_only(_auditor, errors)
              errors[:error_count]
            end

            def auditors_data
              Data::Database::ErrorsPresenter.instance.call
            end
          end
        end
      end
    end
  end
end
