module Inquisition
  module Errors
    class BaseConfigAbsenseError < BaseError
      def initialize
        super('run inquisition install first')
      end
    end
  end
end
