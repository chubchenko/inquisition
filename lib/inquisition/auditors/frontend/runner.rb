module Inquisition
  module Auditors
    module Frontend
      class Runner < Core::Runners::MultipleRunner
        class << self
          private

          def runners
            {
              I18nTasks::Runner => config_path(:i18n_tasks)
            }
          end

          def path
            [:frontend]
          end
        end
      end
    end
  end
end
