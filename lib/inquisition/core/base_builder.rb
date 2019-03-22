module Inquisition
  module Core
    class BaseBuilder
      def initialize(auditors_tree)
        @auditors_tree = auditors_tree
      end

      def call
        raise NotImplementedError
      end
    end
  end
end
