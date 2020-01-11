require_relative 'base'
require_relative 'home'
require_relative 'stack'
require_relative 'security'
require_relative 'bottleneck'
require_relative 'quality'
require_relative 'db'

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

          def bottleneck
            @bottleneck ||= begin
              Template.new('bottleneck').render(TPL::Bottleneck.new(@issues))
            end
          end

          def quality
            @quality ||= begin
              Template.new('quality').render(Quality.new(@issues))
            end
          end

          def db
            @db ||= begin
              Template.new('db').render(TPL::DB.new(@issues))
            end
          end
        end
      end
    end
  end
end
