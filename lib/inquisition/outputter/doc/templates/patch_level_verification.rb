require_relative 'base_template'
require_relative '../gem_details'

module Inquisition
  module Outputter
    class Doc
      module Templates
        class PatchLevelVerification < BaseTemplate
          def group_bundler_audit_issues
            collect_issues('bundler_audit')&.group_by do |issue|
              gem = GemDetails.new(issue.aditional_data.gem.name)
              { name: gem.name, link: gem.link }
            end
          end
        end
      end
    end
  end
end
