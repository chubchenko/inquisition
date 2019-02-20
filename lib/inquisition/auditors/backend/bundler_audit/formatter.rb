module Inquisition
  module Auditors
    module Backend
      module BundlerAudit
        class Formatter < Core::BaseFormatter
          REPORT_KEYS = {
            lintable_name: 'Name',
            message: 'Title',
            type: 'Criticality'
          }.freeze

          private

          def build_errors
            @build_errors ||= raw_errors.map do |vulnerability|
              {
                lintable_name: vulnerability[REPORT_KEYS[:lintable_name]],
                lintable_type: lintable_type_default,
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
