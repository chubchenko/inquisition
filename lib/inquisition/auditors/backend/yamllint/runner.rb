module Inquisition
  module Auditors
    module Backend
      module Yamllint
        class Runner < Auditors::Runner
          private

          def command
            "yamllint #{yml_files.join(' ')}"
          end

          def yml_files
            Dir['./**/*.yml'].reject { |file| include_path?(file) }
          end

          def include_path?(file)
            %w[node_modules test].any? { |path| file.include?(path) }
          end
        end
      end
    end
  end
end
