require 'singleton'

module Inquisition
  module Core
    class AuditorsData
      include Singleton
      attr_reader :data

      COMMON_GROUPS = %i[inquisition linters].freeze

      def auditor_errors(auditor, *keys)
        data.dig(*auditor_path[auditor], *keys) || {}
      end

      def auditor_path
        @auditor_path ||= BaseConfig::AUDITOR_PATH.transform_values(&method(:remove_common_groups))
      end

      def add_data(data)
        @data = data
      end

      private

      def remove_common_groups(value)
        value - COMMON_GROUPS
      end
    end
  end
end
