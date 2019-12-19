module Inquisition
  module Outputter
    class Doc
      module Filters
        module Brakeman
          class Collection
            def initialize(data)
              @data = data.select { |issue| issue.runner.eql?(::Inquisition::Brakeman::Runner) }
              @grouped = @data.group_by { |issue| issue.severity.name }
            end

            def tally(&block)
              @data.group_by(&:context).each do |type, collection|
                block.call(type, collection.count)
              end
            end

            def count
              @count ||= @data.count
            end

            def high
              @high ||= @grouped[:high] || []
            end
          end
        end
      end
    end
  end
end
