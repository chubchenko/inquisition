module Inquisition
  module Core
    module Presenters
      module Pages
        class IssuesAndSolutionsPagePresenter < PagePresenter
          attr_reader :issues

          def initialize(auditors_tree, page_name)
            super
            @issues = IssuesPipelinePresenter.new(@auditors_tree).call
          end

          def total_issues
            issues[:total]
          end
        end
      end
    end
  end
end
