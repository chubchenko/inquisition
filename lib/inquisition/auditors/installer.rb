module Inquisition
  module Auditors
    class Installer
      class << self
        def call
          run_checkers
          run_configers
        end

        private

        def run_checkers
          checkers.each(&:call)
        end

        def run_configers
          configers.each(&:call)
        end

        def checkers
          []
        end

        def configers
          []
        end
      end
    end
  end
end
