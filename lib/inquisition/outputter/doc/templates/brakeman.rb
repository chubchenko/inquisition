require_relative 'base_template'

module Inquisition
  module Outputter
    class Doc
      module Templates
        class Brakeman < BaseTemplate
          def group_brakeman_issues_by_warnings
            collect_issues('brakeman')&.group_by { |issue| issue.aditional_data.warning_type }
          end
        end
      end
    end
  end
end
