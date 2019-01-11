module Inquisition
  module Errors
    class InvalidRubyVersionError < BaseError
      def initialize(version)
        super(I18n.t('errors.invalid_ruby_version', version: version))
      end
    end
  end
end
