module Inquisition
  module Outputter
    class Xlsx
      Row = Class.new do
        def to_a
          raise(NotImplementedError)
        end
      end
    end
  end
end
