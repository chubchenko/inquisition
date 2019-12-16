module Inquisition
  module Outputter
    class Xlsx
      class Table
        def initialize(collector = Collector.new)
          @collector = collector
        end

        def each(&block)
          @collector.call.unshift(Header.new).each(&block)
        end
      end
    end
  end
end
