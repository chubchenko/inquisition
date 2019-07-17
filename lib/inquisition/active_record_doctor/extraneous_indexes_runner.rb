module Inquisition
  module ActiveRecordDoctor
    class ExtraneousIndexesRunner < ::Inquisition::Runner
      include RunnerHelper

      private

      def executor
        ::ActiveRecordDoctor::Tasks::ExtraneousIndexes
      end

      def warning_message
        'extraneous indexes'
      end
    end
  end
end
