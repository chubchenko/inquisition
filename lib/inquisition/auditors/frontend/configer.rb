module Inquisition
  module Auditors
    module Frontend
      class Configer
        def self.call
          puts I18n.t('messages.front_configs_setuped')
        end
      end
    end
  end
end
