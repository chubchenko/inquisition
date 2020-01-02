require_relative 'base'
require_relative 'home'
require_relative 'stack'
require_relative 'security'
require_relative 'analysis'
require_relative 'database_structure'

module Inquisition
  module Outputter
    class Doc
      module TPL
        class Layout < Base
          def initialize(issues)
            @issues = issues
          end

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

          def security
            @security ||= begin
              Template.new('security').render(Security.new(@issues))
            end
          end

          def analysis
            @analysis ||= begin
              Template.new('analysis').render(Analysis.new(@issues))
            end
          end

          def database_structure
            @database_structure ||= begin
              Template.new('database_structure').render(DatabaseStructure.new(@issues))
            end
          end
        end
      end
    end
  end
end
