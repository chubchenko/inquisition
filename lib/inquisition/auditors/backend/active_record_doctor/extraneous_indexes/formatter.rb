module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        module ExtraneousIndexes
          class Formatter < Core::BaseFormatter
            REPORT_KEYS = {
              split_index: 'on_',
              split_multiple_index: '_and_',
              split_table_index: 'index_',
              split_table_on: '_on',
              type_by_default: 'extraneous_indexes'
            }.freeze

            private

            def build_errors
              @build_errors ||= column_with_errors.map(&method(:build_error)).flatten
            end

            def build_total_files_count
              build_errors.map { |error| error[:table] }.uniq.size
            end

            def build_error(error)
              message = error[:message]
              prepare_columns(message).map do |column|
                {
                  table: prepare_table(error[:index]),
                  column: column,
                  message: message,
                  type: type_default
                }
              end
            end

            def prepare_columns(error)
              return [] unless error

              error.split(REPORT_KEYS[:split_index]).last
                   .split(REPORT_KEYS[:split_multiple_index]).map(&method(:text_only))
            end

            def prepare_table(index)
              index.split(REPORT_KEYS[:split_table_index]).last.split(REPORT_KEYS[:split_table_on]).first
            end

            def type_default
              REPORT_KEYS[:type_by_default]
            end

            def raw_errors
              @raw_errors ||= @unparsed_data.split("\n")
            end

            def column_with_errors
              @column_with_errors ||= raw_errors.tap(&:shift).map(&method(:prepare_errors)).flatten
            end

            def prepare_errors(error)
              index, message = error.split(' (')
              { index: index, message: message }
            end
          end
        end
      end
    end
  end
end
