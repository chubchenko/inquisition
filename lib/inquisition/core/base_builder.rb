module Inquisition
  module Core
    class BaseBuilder
      def call
        raise NotImplementedError
      end
    end
  end
end
