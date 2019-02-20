module Inquisition
  module Core
    class BaseRunner
      def call
        raise NotImplementedError
      end
    end
  end
end
