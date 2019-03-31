module Inquisition
  module Auditors
    module Frontend
      class Runner < Core::Runners::MultipleRunner
        class << self
          private

          def runners
            {
              I18nTasks::Runner => :i18n_tasks
            }
          end
        end
      end
    end
  end
end
