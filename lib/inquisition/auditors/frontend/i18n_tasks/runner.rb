module Inquisition
  module Auditors
    module Frontend
      module I18nTasks
        class Runner < Auditors::Runner
          private

          def command
            'i18n-tasks health -f json'
          end
        end
      end
    end
  end
end
