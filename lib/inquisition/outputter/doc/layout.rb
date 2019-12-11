require_relative 'home'

module Inquisition
  module Outputter
    class Doc
      class Layout
        def produce
          binding
        end

        def home
          @home ||= begin
            Template.new('home').render(Home.new)
          end
        end
      end
    end
  end
end
