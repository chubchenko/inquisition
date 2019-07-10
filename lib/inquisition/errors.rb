module Inquisition
  module Errors
    class AdditionalSoftwareAbsenceError < StandardError
      def initialize(command)
        super("Additional software with command #{command} not found")
      end
    end

    class BaseConfigAbsenseError < StandardError
      def initialize
        super('Run inquisition build first')
      end
    end

    class InvalidRubyVersionError < StandardError
      def initialize(version)
        super("Invalid ruby version #{version}")
      end
    end

    class NoConfigFileError < StandardError
      def initialize(name)
        super("File #{name} not found")
      end
    end

    class NoGemError < StandardError
      def initialize(name)
        super("Gem #{name} not found")
      end
    end
  end
end
