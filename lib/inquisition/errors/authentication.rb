module Inquisition
  module Errors
    class AuthenticationError < StandardError
      def initialize
        super('run inquisition install first')
      end
    end
  end
end
