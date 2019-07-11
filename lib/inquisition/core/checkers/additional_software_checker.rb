module Inquisition
  module Core
    module Checkers
      class AdditionalSoftwareChecker < Inquisition::Core::Checker
        NOT_FOUND_TEXT = 'not found'.freeze

        private

        def check
          raise Error::AdditionalSoftwareAbsenceError, @args[:command] if software_missing?
        end

        def software_missing?
          stdout = run_cli(@args[:command])
          stdout.empty? || stdout.downcase.include?(NOT_FOUND_TEXT)
        end
      end
    end
  end
end
