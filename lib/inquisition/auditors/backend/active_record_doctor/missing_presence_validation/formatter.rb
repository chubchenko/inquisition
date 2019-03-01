module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module MissingPresenceValidation
          class Formatter < Core::BaseFormatter
            REPORT_KEYS = {
              type_by_default: 'missing_presence_validation'
            }.freeze

            private

            def build_errors
              @build_errors ||= columns_with_error.map(&method(:build_error)).flatten
            end

            def build_total_files_count
              build_errors.map { |error| error[:table] }.uniq.size
            end

            def build_error(error)
              prepare_columns(error[:columns]).map do |column|
                {
                  table: text_only(error[:table]),
                  column: column,
                  message: raw_errors.first,
                  type: type_default
                }
              end
            end

            def prepare_columns(columns)
              columns.map { |column| column.split(', ') }.flatten.map(&method(:text_only))
            end

            def raw_errors
              @raw_errors ||= @unparsed_data.split("\n")
            end

            def columns_with_error
              @columns_with_error ||= raw_errors.dup.tap(&:shift).map(&method(:prepare_errors))
            end

            def prepare_errors(error)
              table, *columns = error.split(':')
              { table: table, columns: columns }
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
