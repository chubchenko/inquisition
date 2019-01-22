module Inquisition
  module Auditors
    module Backend
      module Reek
        class Formatter < Core::BaseFormatter
          REPORT_KEYS = {
            linterable_name: 'source',
            message: 'message',
            type: 'smell_type',
            list_of_errors: 'lines'
          }.freeze

          private

          def build_errors
            @build_errors ||= raw_errors.map(&method(:build_error)).flatten
          end

          def build_error(error)
            error[REPORT_KEYS[:list_of_errors]].map do |line|
              {
                linterable_name: error[REPORT_KEYS[:linterable_name]],
                linterable_type: linterable_type_default,
                message: error[REPORT_KEYS[:message]],
                type: error[REPORT_KEYS[:type]],
                line: line
              }
            end
          end

          def raw_errors
            @raw_errors ||= JSON.parse(@unparsed_data)
          end
        end
      end
    end
  end
end
