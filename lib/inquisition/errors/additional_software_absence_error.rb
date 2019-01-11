module Inquisition
  module Errors
    class AdditionalSoftwareAbsenceError < BaseError
      def initialize(command)
        super(I18n.t('errors.absence_additional_software', command: command))
      end
    end
  end
end
