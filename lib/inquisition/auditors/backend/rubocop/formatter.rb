module Inquisition
  module Auditors
    module Backend
      module Rubocop
        class Formatter < Core::BaseFormatter
          REPORT_KEYS = {
            linterable_name: 'path',
            message: 'message',
            type: 'severity',
            line: %w[location line],
            total_files_count: %w[summary inspected_file_count],
            error_count: %w[summary offense_count],
            list_of_errors: 'offenses',
            list_of_files: 'files'
          }.freeze

          private

          def build_errors
            @build_errors ||= file_with_errors.map(&method(:build_error)).flatten
          end

          def build_error_count
            raw_errors.dig(*REPORT_KEYS[:error_count])
          end

          def build_total_files_count
            raw_errors.dig(*REPORT_KEYS[:total_files_count])
          end

          def build_error(file)
            file[REPORT_KEYS[:list_of_errors]].map do |offense|
              {
                linterable_name: file[REPORT_KEYS[:linterable_name]],
                linterable_type: linterable_type_default,
                message: offense[REPORT_KEYS[:message]],
                type: offense[REPORT_KEYS[:type]],
                line: offense.dig(*REPORT_KEYS[:line])
              }
            end
          end

          def file_with_errors
            raw_errors[REPORT_KEYS[:list_of_files]].select { |file| file[REPORT_KEYS[:list_of_errors]].any? }
          end

          def raw_errors
            @raw_errors ||= JSON.parse(@unparsed_data)
          end
        end
      end
    end
  end
end
