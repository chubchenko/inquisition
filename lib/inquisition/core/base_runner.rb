module Inquisition
  module Core
    class BaseRunner
      UPCASE_REGEXP_FORMAT = /(?=[A-Z])/.freeze

      def call
        raise NotImplementedError
      end

      def self.auditor_namespase
        name.split('::').tap(&:pop).join('::')
      end

      def self.auditor_name
        auditor_namespase.split('::').last.split(UPCASE_REGEXP_FORMAT).map(&:downcase).join('_')
      end
    end
  end
end
