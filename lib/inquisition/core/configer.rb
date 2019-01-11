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
    end
  end
end
