module Inquisition
  module Errors
    class NoConfigFileError < BaseError
      def initialize(name)
        super(I18n.t('errors.no_config_file', name: name))
      end
    end
  end
end
