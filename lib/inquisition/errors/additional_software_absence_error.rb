module Inquisition
  module Errors
    class AdditionalSoftwareAbsenceError < BaseError
      def initialize(command)
        super("Additional software with command #{command} not found")
      end
    end
  end
end
