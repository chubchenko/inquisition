module Inquisition
  module Auditors
    module Common
      class Installer
        def self.call
          Messenger.common_configs_setuped
        end
      end
    end
  end
end
