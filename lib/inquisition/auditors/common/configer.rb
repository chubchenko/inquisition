module Inquisition
  module Auditors
    module Common
      class Configer
        def self.call
          Outputer.common_configs_setuped
        end
      end
    end
  end
end
