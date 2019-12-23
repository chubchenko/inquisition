require_relative 'base'
require_relative 'home'
require_relative 'stack'

module Inquisition
  module Outputter
    class Doc
      module TPL
        class Layout < Base
          def home
            @home ||= begin
              Template.new('home').render(Home.new)
            end
          end

          def stack
            @stack ||= begin
              Template.new('stack').render(Stack.new)
            end
          end
        end
      end
    end
  end
end
