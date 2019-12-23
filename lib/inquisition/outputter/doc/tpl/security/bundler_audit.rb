module Inquisition
  module Outputter
    class Doc
      module TPL
        class Security
          class BundlerAudit < SimpleDelegator
            def self.call(issues)
              new(Collection.new(issues))
            end

            def produce
              binding
            end

            class Collection
              def initialize(issues)
                @issues = issues.select { |issue| issue.runner.is_a?(::Inquisition::Bundler::Audit::Runner) }
              end

              def group
                @issues&.group_by { |issue| GemDetails.new(issue.context.name).to_h }
              end

              def count
                @issues.count
              end

              def high
                @high ||= by_severity.fetch(:high) { [].freeze }
              end

              private

              attr_reader :issues

              def by_severity
                @by_severity ||= begin
                  issues.group_by { |issue| issue.severity.name }
                end
              end
            end
          end
        end
      end
    end
  end
end
