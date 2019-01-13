module Inquisition
  module Auditors
    module Frontend
      class Installer
        def self.call
          Outputer.front_configs_setuped
        end
      end
    end
  end
end
