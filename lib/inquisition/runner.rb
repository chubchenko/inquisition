module Inquisition
  class Runner
    extend Inquisition::Authorization

    class << self
      def call
        authenticate_runner
        run_runners
      end

      private

      def run_runners
        runners.each do |runner, path|
          runner.call if BaseConfig.config_enabled?(*path)
        end
      end

      def runners
        {
          Auditors::Backend::Runner => config_path(:backend)
          # Auditors::Frontend::Runner => config_path(:frontend),
          # Auditors::Common::Runner => config_path(:common)
        }
      end

      def config_path(*path)
        [:linters, *path]
      end
    end
  end
end
