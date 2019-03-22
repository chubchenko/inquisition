module Inquisition
  module Helpers
    module NamespaceHelper
      UPCASE_REGEXP_FORMAT = /(?=[A-Z])/.freeze

      def auditor_namespase
        self.class.name.split('::').tap(&:pop).join('::')
      end

      def auditor_name
        auditor_namespase.split('::').last.split(UPCASE_REGEXP_FORMAT).map(&:downcase).join('_')
      end
    end
  end
end
