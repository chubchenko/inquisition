module Inquisition
  module Core
    class BasePresenter
      attr_reader :presenter

      def initialize
        @presenter = {}
      end

      def call
        build_presenter
        @presenter
      end

      def build_presenter
        raise NotImplementedError
      end
    end
  end
end
