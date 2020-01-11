module Inquisition
  module Outputter
    class Doc
      module TPL
        class Quality < Base
          def initialize(issues)
            @issues = issues
          end

          def rubycritic
            @rubycritic ||= begin
              Template.new('quality/rubycritic').render(Rubycritic.call(@issues))
            end
          end
        end
      end
    end
  end
end

require_relative 'quality/rubycritic'
