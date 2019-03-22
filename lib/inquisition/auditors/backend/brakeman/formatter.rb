module Inquisition
  module Auditors
    module Backend
      module Brakeman
        class Formatter < Core::BaseFormatter
          include Helpers::NamespaceHelper

          AUDITOR_LINK = 'https://github.com/presidentbeef/brakeman'.freeze
          CONFIDENCE_LINK = 'https://brakemanscanner.org/docs/confidence/'.freeze
          HOTTEST_ISSUE_GROUP = 'security'.freeze
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
            template_count: 'number_of_templates',
            issue_title: 'warning_type',
            issue_confidence: 'confidence',
            issue_link: 'link',
            issue_file: 'file',
            issue_line: 'line'
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

          def build_special_info
            {
              hottest_issues: build_hottest_issues
            }
          end

          def build_error_count
            raw_errors[REPORT_KEYS[:info_key]][REPORT_KEYS[:error_count]]
          end

          def build_total_files_count
            raw_errors[REPORT_KEYS[:info_key]].slice(REPORT_KEYS[:controller_count],
                                                     REPORT_KEYS[:model_count],
                                                     REPORT_KEYS[:template_count]).values.sum
          end

          def build_hottest_issues
            raw_errors[REPORT_KEYS[:error_key]].map do |info|
              {
                title: info[REPORT_KEYS[:issue_title]],
                auditor_name: auditor_name.capitalize,
                auditor_link: AUDITOR_LINK,
                confidence: info[REPORT_KEYS[:issue_confidence]],
                confidence_link: CONFIDENCE_LINK,
                message: build_message_key(info),
                file: build_file_key(info),
                link: info[REPORT_KEYS[:issue_link]],
                group: HOTTEST_ISSUE_GROUP.capitalize
              }
            end
          end

          def build_message_key(info)
            report_attribute(info, :message) + '.'
          end

          def build_file_key(info)
            report_attribute(info, :issue_file) + ':' + report_attribute(info, :issue_line)
          end

          def report_attribute(report, key)
            report.dig(REPORT_KEYS[key]).to_s
          end

          def raw_errors
            @raw_errors ||= JSON.parse(@unparsed_data)
          end
        end
      end
    end
  end
end
