require_relative '../gem_details'
require_relative 'stack'
require_relative 'home'
require_relative 'base'
require_relative 'security'

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

          def technology_stack
            @technology_stack ||= begin
              Template.new('stack').render(Stack.new)
            end
          end

          def security
            @security ||= begin
              Template.new('security').render(Security.new(@issues))
            end
          end
        end
      end
    end
  end
end
