require 'set'

module Inquisition
  module Plugin
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    module ClassMethods
      def collection
        @collection ||= Set.new
      end

      def inherited(descendant)
        collection << descendant
      end
    end
  end
end
