require 'forwardable'

module Inquisition
  module Core
    class BasePresenter
      extend Forwardable

      CIRCLE_CHART_COLORS = %i[blue green purple aero red].freeze

      def initialize(data = nil)
        @data = data
      end

      def call
        build_presenter
      end

      def run_cli(command)
        begin
          stdout = Open3.capture3(command).first
        rescue Errno::ENOENT
          stdout = ''
        end
        stdout
      end

      def build_presenter
        raise NotImplementedError
      end
    end
  end
end
