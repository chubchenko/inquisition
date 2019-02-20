module Inquisition
  module Errors
    class NoGemError < BaseError
      def initialize(name)
        super(I18n.t('errors.no_gem', name: name))
      end
    end
  end
end
