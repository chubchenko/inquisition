module Inquisition
  module Errors
    class AuthenticationError < StandardError
      def initialize
        # puts 'run     s install first'
        super('asd')
        # exit
      end
    end
  end
end
