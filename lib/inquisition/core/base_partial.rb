module Inquisition
  module Core
    class BasePartial
      def partial
        raise NotImplementedError
      end
    end
  end
end
