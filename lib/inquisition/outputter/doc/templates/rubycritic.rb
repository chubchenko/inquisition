require_relative 'base_template'

module Inquisition
  module Outputter
    class Doc
      module Templates
        class Rubycritic < BaseTemplate
          MIN_SCORE = 0

          def group_smells_with_difficulties
            difficulty_issues = collect_issues('rubycritic')&.group_by { |issue| issue.severity.name }
            collect_issues_with_types(difficulty_issues).reduce({}, :merge)
          end

          def common_smells_score
            collect_issues('rubycritic')&.first&.runner&.common_score || MIN_SCORE
          end

          private

          def collect_issues_with_types(difficulty_issues)
            difficulty_issues.map do |level, issues|
              { level => issues.group_by { |issue| issue.aditional_data.type } }
            end
          end
        end
      end
    end
  end
end
