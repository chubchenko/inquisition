require_relative 'doc/builder'

module Inquisition
  module Outputter
    class Doc
      Outputter.declare(self, :stop)

      def initialize(_output); end

      def stop(payload)
        Builder.call(payload)
      end
    end
  end
end
