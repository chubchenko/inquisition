module Inquisition
  module Core
    class BaseRunner
      class << self
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

        def config_path(*path)
          [:linters, *path]
        end
      end
    end
  end
end
