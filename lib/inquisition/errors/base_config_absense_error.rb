module Inquisition
  module Errors
    class BaseConfigAbsenseError < StandardError
      def initialize
        super('run inquisition install first')
      end
    end
  end
end
