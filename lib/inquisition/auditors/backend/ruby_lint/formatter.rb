module Inquisition
  module Auditors
    module Backend
      module RubyLint
        class Formatter < Core::BaseFormatter
          REPORT_KEYS = {
            lintable_name: 'file',
            message: 'message',
            line: 'line',
            type: 'level'
          }.freeze

          private

          def build_errors
            @build_errors ||= raw_errors.map(&method(:build_error))
          end

          def build_error(error)
            {
              lintable_name: error[REPORT_KEYS[:lintable_name]],
              lintable_type: lintable_type_default,
              message: error[REPORT_KEYS[:message]],
              type: error[REPORT_KEYS[:type]],
              line: error[REPORT_KEYS[:line]]
            }
          end

          def raw_errors
            @raw_errors ||= JSON.parse(@unparsed_data)
          end
        end
      end
    end
  end
end
