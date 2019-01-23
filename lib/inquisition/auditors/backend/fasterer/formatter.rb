module Inquisition
  module Auditors
    module Backend
      module Fasterer
        class Formatter < Core::BaseFormatter
          REPORT_KEYS = {
            message: ' Occurred',
            line: 'at lines:',
            message_split_text: ' Occurred',
            error_split_text: 'at lines:'
          }.freeze

          private

          def build_errors
            @build_errors ||= Hash[*file_with_errors].map(&method(:build_error)).flatten
          end

          def build_error(file_name, error_message)
            prepare_error_lines(error_message).map do |line|
              {
                linterable_name: file_name,
                linterable_type: linterable_type_default,
                message: prepare_message(error_message),
                type: type_default,
                line: line
              }
            end
          end

          def prepare_message(message)
            message.split(REPORT_KEYS[:message_split_text]).first
          end

          def prepare_error_lines(message)
            message.split(REPORT_KEYS[:error_split_text]).last.split(',').map(&:to_i)
          end

          def file_with_errors
            @file_with_errors ||= raw_errors.reject(&:empty?).tap(&:pop)
          end

          def raw_errors
            @raw_errors ||= @unparsed_data.uncolorize.split("\n")
          end
        end
      end
    end
  end
end
