module Inquisition
  module Errors
    class BaseConfigAbsenseError < BaseError
      def initialize
        super('Run inquisition build first')
      end
    end
  end
end
