module Inquisition
  module Errors
    class NoConfigFileError < BaseError
      def initialize(name)
        super("File #{name} not found")
      end
    end
  end
end
