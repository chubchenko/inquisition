module Inquisition
  module Core
    class BaseRunner
      include Helpers::NamespaceHelper

      def call
        raise NotImplementedError
      end
    end
  end
end
