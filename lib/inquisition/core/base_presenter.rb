module Inquisition
  module Core
    class BasePresenter
      def initialize(data = nil)
        @data = data
      end

      def call
        build_presenter
      end

      def build_presenter
        raise NotImplementedError
      end
    end
  end
end
