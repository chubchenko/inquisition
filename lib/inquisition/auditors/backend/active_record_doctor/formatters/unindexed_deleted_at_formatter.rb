module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module Formatters
          class UnindexedDeletedAtFormatter < Core::BaseFormatter
            REPORT_KEYS = {
              type_by_default: 'unindexed_deleted_at',
              split_table_name: 'index_',
              split_column: '_on'
            }.freeze

            private

            def build_errors
              @build_errors ||= columns_with_error.map(&method(:build_error))
            end

            def build_total_files_count
              build_errors.map { |error| error[:table] }.uniq.size
            end

            def build_error(error)
              {
                table: error[:table],
                column: text_only(error[:index]),
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
              table = error.split(REPORT_KEYS[:split_table_name]).last.split(REPORT_KEYS[:split_column]).first
              { table: table, index: error }
            end

            def type_default
              REPORT_KEYS[:type_by_default]
            end
          end
        end
      end
    end
  end
end
