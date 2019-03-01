module Inquisition
  module Core
    class BaseBuilder
      def initialize(auditors_tree)
        @auditors_tree = auditors_tree
      end

      def call
        NotImplementedError
      end
    end
  end
end
