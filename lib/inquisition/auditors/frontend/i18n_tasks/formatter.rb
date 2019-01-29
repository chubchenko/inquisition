module Inquisition
  module Auditors
    module Frontend
      module I18nTasks
        class Formatter < Core::BaseFormatter
          REPORT_KEYS = {
            linterable_name: 'filename',
            message: 'message',
            line: 'line_number'
          }.freeze

          private

          def build_errors
            @build_errors ||= raw_errors.map(&method(:build_error))
          end

          def build_error(error)
            {
              linterable_name: error[REPORT_KEYS[:linterable_name]],
              linterable_type: linterable_type_default,
              message: error[REPORT_KEYS[:message]],
              type: type_default,
              line: error[REPORT_KEYS[:line]]
            }
          end

          def raw_errors
            @raw_errors ||= JSON.parse(read_report_file)
          end

          def read_report_file
            File.read('rails_best_practices_output.json')
          end
        end
      end
    end
  end
end
