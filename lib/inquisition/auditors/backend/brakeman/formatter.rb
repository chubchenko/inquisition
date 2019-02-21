module Inquisition
  module Auditors
    module Backend
      module Brakeman
        class Formatter < Core::BaseFormatter
          REPORT_KEYS = {
            lintable_name: 'file',
            message: 'message',
            line: 'line',
            type: 'warning_type',
            error_count: 'security_warnings',
            error_key: 'warnings',
            info_key: 'scan_info',
            controller_count: 'number_of_controllers',
            model_count: 'number_of_models',
            template_count: 'number_of_templates'
          }.freeze

          private

          def build_errors
            @build_errors ||= raw_errors[REPORT_KEYS[:error_key]].map do |error|
              {
                lintable_name: error[REPORT_KEYS[:lintable_name]],
                lintable_type: lintable_type_default,
                message: error[REPORT_KEYS[:message]],
                type: error[REPORT_KEYS[:type]],
                line: error[REPORT_KEYS[:line]]
              }
            end
          end

          def build_error_count
            raw_errors[REPORT_KEYS[:info_key]][REPORT_KEYS[:error_count]]
          end

          def build_total_files_count
            raw_errors[REPORT_KEYS[:info_key]].slice(REPORT_KEYS[:controller_count],
                                                     REPORT_KEYS[:model_count],
                                                     REPORT_KEYS[:template_count]).values.sum
          end

          def raw_errors
            @raw_errors ||= JSON.parse(@unparsed_data)
          end
        end
      end
    end
  end
end
