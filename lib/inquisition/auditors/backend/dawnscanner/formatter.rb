module Inquisition
  module Auditors
    module Backend
      module Dawnscanner
        class Formatter < Core::BaseFormatter
          REPORT_KEYS = {
            message: 'message',
            type: 'severity',
            error_count: 'vulnerabilities_count',
            list_of_errors: 'vulnerabilities'
          }.freeze

          private

          def build_errors
            @build_errors ||= raw_errors[REPORT_KEYS[:list_of_errors]].map do |vulnerability|
              {
                lintable_name: lintable_name_default,
                lintable_type: lintable_type_gem,
                message: vulnerability[REPORT_KEYS[:message]],
                type: vulnerability[REPORT_KEYS[:type]],
                line: line_default
              }
            end
          end

          def build_error_count
            raw_errors[REPORT_KEYS[:error_count]]
          end

          def build_total_files_count
            default_total_files
          end

          def raw_errors
            @raw_errors ||= JSON.parse(@unparsed_data.scan(JSON_REGEXP_FORMAT).first)
          end
        end
      end
    end
  end
end
