module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module UnindexedForeignKeys
          class Formatter < Core::BaseFormatter
            REPORT_KEYS = {
              type_by_default: 'unindexed_foreign_keys',
              message_by_default: ''
            }.freeze

            private

            def build_errors
              @build_errors ||= columns_with_error.map(&method(:build_error)).flatten
            end

            def build_total_files_count
              build_errors.map { |error| error[:table] }.uniq.size
            end

            def build_error(error)
              error[:columns].map do |column|
                {
                  table: error[:table],
                  column: column,
                  message: message_by_default,
                  type: type_default
                }
              end
            end

            def raw_errors
              @raw_errors ||= @unparsed_data.split("\n")
            end

            def columns_with_error
              @columns_with_error ||= raw_errors.map(&method(:prepare_errors))
            end

            def prepare_errors(error)
              table, *columns = error.split
              { table: table, columns: columns }
            end

            def type_default
              REPORT_KEYS[:type_by_default]
            end

            def message_by_default
              REPORT_KEYS[:message_by_default]
            end
          end
        end
      end
    end
  end
end
