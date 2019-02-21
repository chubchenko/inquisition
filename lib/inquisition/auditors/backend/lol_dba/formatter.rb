module Inquisition
  module Auditors
    module Backend
      module LolDba
        class Formatter < Core::BaseFormatter
          REPORT_KEYS = {
            error_split_text: 'def change'
          }.freeze

          private

          def build_errors
            @build_errors ||= column_with_errors.map(&method(:build_error)).flatten
          end

          def build_total_files_count
            @build_errors.map { |error| error[:table] }.uniq.count
          end

          def build_error(error)
            prepare_columns(error[:column]).map do |column|
              {
                table: text_only(error[:table]),
                column: column,
                message: message_default,
                type: text_only(error[:type])
              }
            end
          end

          def prepare_columns(columns)
            columns.map(&method(:text_only))
          end

          def raw_errors
            @raw_errors ||= @unparsed_data.split(REPORT_KEYS[:error_split_text])
          end

          def column_with_errors
            @column_with_errors = raw_errors.any? ? raw_errors.last.split("\n").map(&method(:prepare_errors)) : []
          end

          def prepare_errors(error)
            type, table, *column = error.split(':')
            {
              type: type,
              table: table,
              column: column
            }
          end
        end
      end
    end
  end
end
