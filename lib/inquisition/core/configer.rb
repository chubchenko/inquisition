module Inquisition
  module Core
    class Configer
      def initialize(args = {})
        @args = args
      end

      def call
        setup
      end

      private

      def target_directory
        Dir.pwd
      end

      def destination
        destination = @args[:destination]
        destination ? File.join(target_directory, destination) : target_directory
      end
    end
  end
end
