require_relative 'html/builder'

module Inquisition
  module Outputter
    class HTML
      Outputter.declare(self, :stop)

      def initialize(_output); end

      def stop(issues)
        Builder.call(issues)
      end
    end
  end
end
