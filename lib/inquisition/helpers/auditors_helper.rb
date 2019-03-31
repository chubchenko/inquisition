module Inquisition
  module Helpers
    module AuditorsHelper
      def auditor_enabled?(path)
        BaseConfig.instance.auditor_enabled?(path)
      end

      def auditors_list
        BaseConfig::AUDITOR_PATH.keys - BaseConfig::AUDITORS_GROUP
      end
    end
  end
end
