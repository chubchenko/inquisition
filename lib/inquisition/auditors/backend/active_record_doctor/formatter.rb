module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        class Formatter < Core::BaseFormatter
          REPORT_KEYS = {}.freeze

          private

          def build_errors
            @build_errors ||= raw_errors.map(&method(:build_error))
          end

          def build_error(error)
            {
              lintable_name: error[REPORT_KEYS[:lintable_name]],
              lintable_type: lintable_type_default,
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
