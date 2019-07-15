module Inquisition
  module Auditors
    module Backend
      module I18nTasks
        class Runner < Core::Runners::SingleRunner
          private

          def command
            'i18n-tasks health -f json'
          end
        end
      end
    end
  end
end
