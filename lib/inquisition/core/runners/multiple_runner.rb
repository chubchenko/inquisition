module Inquisition
  module Core
    module Runners
      class MultipleRunner < BaseRunner
        def call
          run_runners
        end

        private

        def run_runners
          runners.each do |runner, path|
            runner.new.call if BaseConfig.config_enabled?(*path)
          end
        end

        def runners
          {}
        end

        def config_path(*keys)
          [:linters, *path, *keys]
        end

        def path
          []
        end
      end
    end
  end
end
