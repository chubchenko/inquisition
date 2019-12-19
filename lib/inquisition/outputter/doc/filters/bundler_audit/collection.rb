module Inquisition
  module Outputter
    class Doc
      module Filters
        module BundlerAudit
          class Collection
            def initialize(data)
              @data = data.select { |issue| issue.runner.eql?(::Inquisition::Bundler::Audit::Runner) }
            end

            def group
              @data&.group_by { |issue| GemDetails.new(issue.context.name).to_h }
            end

            def count
              @data.count
            end

            def high
              @data&.group_by { |issue| issue.severity.name }[:high] || []
            end
          end
        end
      end
    end
  end
end
