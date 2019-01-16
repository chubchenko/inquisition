module Inquisition
  module Auditors
    module Backend
      class Configer
        def self.call
          Fasterer::Installer.call
        end
      end
    end
  end
end
