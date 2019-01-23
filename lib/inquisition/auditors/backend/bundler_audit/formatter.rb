module Inquisition
  module Auditors
    module Backend
      module BundlerAudit
        class Formatter < Core::BaseFormatter
          REPORT_KEYS = {
            linterable_name: 'Name',
            message: 'Title',
            type: 'Criticality'
          }.freeze

          private

          def build_errors
            @build_errors ||= raw_errors.map do |vulnerability|
              {
                linterable_name: vulnerability[REPORT_KEYS[:linterable_name]],
                linterable_type: linterable_type_default,
                message: vulnerability[REPORT_KEYS[:message]],
                type: vulnerability[type],
                line: line_default
              }
            end
          end

          def raw_errors
            @raw_errors ||= @unparsed_data.split("\n\n").map(&method(:split_errors)).tap(&:pop)
          end

          def split_errors(errors)
            errors.split("\n").map(&method(:prepare_error_info)).reduce({}, :merge)
          end

          def prepare_error_info(error)
            key, *value = error.split(': ')
            Hash[key, value.join(': ')]
          end
        end
      end
    end
  end
end
