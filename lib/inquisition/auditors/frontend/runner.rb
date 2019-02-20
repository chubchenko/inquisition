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

          def config_path(*path)
            [:linters, :frontend, *path]
          end
        end
      end
    end
  end
end
