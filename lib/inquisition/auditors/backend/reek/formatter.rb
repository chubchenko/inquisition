module Inquisition
  module Auditors
    module Backend
      module Reek
        class Formatter < Core::BaseFormatter
          include Helpers::NamespaceHelper

          REPORT_KEYS = {
            lintable_name: 'source',
            message: 'message',
            type: 'smell_type',
            list_of_errors: 'lines',
            link: 'documentation_link'
          }.freeze
          AUDITOR_LINK = 'https://github.com/troessner/reek'.freeze

          private

          def build_errors
            @build_errors ||= raw_errors.map(&method(:build_error)).flatten
          end

          def build_error(error)
            error[REPORT_KEYS[:list_of_errors]].map do |line|
              {
                lintable_name: error[REPORT_KEYS[:lintable_name]],
                lintable_type: lintable_type_default,
                message: error[REPORT_KEYS[:message]],
                type: error[REPORT_KEYS[:type]],
                line: line
              }
            end
          end

          def build_special_info
            {
              issues: build_issues
            }
          end

          def build_issues
            raw_errors.map do |info|
              {
                title: info[REPORT_KEYS[:type]],
                auditor_name: auditor_name.capitalize,
                auditor_link: AUDITOR_LINK,
                message: build_message(info),
                link: info[REPORT_KEYS[:link]]
              }
            end
          end

          def build_message(info)
            info[REPORT_KEYS[:message]].capitalize + '.'
          end

          def raw_errors
            @raw_errors ||= JSON.parse(@unparsed_data)
          end
        end
      end
    end
  end
end
