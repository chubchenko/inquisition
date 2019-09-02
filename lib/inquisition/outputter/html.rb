module Inquisition
  module Outputter
    class HTML
      Outputter.declare(self, :stop)

      def initialize(_output); end

      def stop(_issues); end
    end
  end
end
