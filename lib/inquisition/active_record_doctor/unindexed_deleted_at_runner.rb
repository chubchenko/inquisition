module Inquisition
  module ActiveRecordDoctor
    class UnindexedDeletedAtRunner < ::Inquisition::Runner
      include RunnerHelper

      private

      def executor
        ::ActiveRecordDoctor::Tasks::UnindexedDeletedAt
      end

      def warning_message
        'unindexed deleted at'
      end
    end
  end
end
