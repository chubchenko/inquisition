module Inquisition
  module Outputter
    class Doc
      module TPL
        class Analysis < Base
          def initialize(issues)
            @issues = issues
          end

          def rubycritic
            @rubycritic ||= begin
              Template.new('analysis/rubycritic').render(Rubycritic.call(@issues))
            end
          end

          def rubocop
            @rubocop ||= begin
              Template.new('analysis/rubocop').render(Rubocop.call(@issues))
            end
          end
        end
      end
    end
  end
end

require_relative 'analysis/rubycritic'
require_relative 'analysis/rubocop'
