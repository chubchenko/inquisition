module Inquisition
  module Core
    class BaseOutputer
      def call
        raise NotImplementedError
      end
    end
  end
end
