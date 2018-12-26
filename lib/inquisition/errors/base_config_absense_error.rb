module Inquisition
  module Errors
    class BaseConfigAbsenseError < BaseError
      def initialize
        super(I18n.t('errors.config_absense_error'))
      end
    end
  end
end
