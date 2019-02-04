module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module Formatters
          class UndefinedTableReferencesFormatter < Core::BaseFormatter
            REPORT_KEYS = {
              split_table_name: 'the table',
              type_by_default: 'undefined_table_references',
              column_by_default: ''
            }.freeze

            private

            def build_errors
              @build_errors ||= columns_with_error.map(&method(:build_error))
            end

            def build_total_files_count
              build_errors.map { |error| error[:table] }.uniq.size
            end

            def build_error(table)
              {
                table: table,
                column: column_default,
                message: raw_errors.first,
                type: type_default
              }
            end

            def raw_errors
              @raw_errors ||= @unparsed_data.split("\n")
            end

            def columns_with_error
              @columns_with_error ||= raw_errors.dup.tap(&:shift).map(&method(:prepare_errors))
            end

            def prepare_errors(error)
              error.split(REPORT_KEYS[:split_table_name]).last.split.first
            end

            def type_default
              REPORT_KEYS[:type_by_default]
            end

            def column_default
              REPORT_KEYS[:column_by_default]
            end
          end
        end
      end
    end
  end
end
