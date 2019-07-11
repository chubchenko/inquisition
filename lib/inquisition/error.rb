module Inquisition
  BaseError = Class.new(StandardError)

  module Error
    class AdditionalSoftwareAbsenceError < BaseError
      def initialize(command)
        super("Additional software with command #{command} not found")
      end
    end

    class BaseConfigAbsenseError < BaseError
      def initialize
        super('Run inquisition build first')
      end
    end

    class InvalidRubyVersionError < BaseError
      def initialize(version)
        super("Invalid ruby version #{version}")
      end
    end

    class NoConfigFileError < BaseError
      def initialize(name)
        super("File #{name} not found")
      end
    end

    class NoGemError < BaseError
      def initialize(name)
        super("Gem #{name} not found")
      end
    end
  end
end
