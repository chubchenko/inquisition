module Inquisition
  module Auditors
    module Common
      class Configer
        def self.call
          puts I18n.t('messages.common_configs_setuped')
        end
      end
    end
  end
end
