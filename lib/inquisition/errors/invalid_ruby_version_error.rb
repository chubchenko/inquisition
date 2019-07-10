module Inquisition
  module Errors
    class InvalidRubyVersionError < BaseError
      def initialize(version)
        super("Invalid ruby version #{version}")
      end
    end
  end
end
