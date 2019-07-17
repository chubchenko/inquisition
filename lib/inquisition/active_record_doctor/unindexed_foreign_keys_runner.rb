module Inquisition
  module ActiveRecordDoctor
    class UnindexedForeignKeysRunner < ::Inquisition::Runner
      include RunnerHelper

      private

      def executor
        ::ActiveRecordDoctor::Tasks::UnindexedForeignKeys
      end

      def warning_message
        'unindexed foreign keys'
      end
    end
  end
end
