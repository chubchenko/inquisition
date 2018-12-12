module Inquisition
  module Auditors
    module Backend
      class Configer
        def self.call
          Fasterer::Configer.call
        end
      end
    end
  end
end
