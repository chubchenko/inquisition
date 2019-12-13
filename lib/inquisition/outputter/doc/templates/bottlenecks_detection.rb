require_relative 'base_template'
require_relative '../technology_stack'

module Inquisition
  module Outputter
    class Doc
      module Templates
        class BottlenecksDetection < BaseTemplate
          def group_fasterer_by_offense
            collect_issues('fasterer')&.group_by { |issue| issue.aditional_data.offense_name }
          end

          def link_to_offense_error(offense)
            TechnologyStack::FASTERER_ISSUE_LINKS[:path] + TechnologyStack::FASTERER_ISSUE_LINKS[:links][offense]
          end
        end
      end
    end
  end
end
