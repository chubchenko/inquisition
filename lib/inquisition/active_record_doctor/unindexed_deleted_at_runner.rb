module Inquisition
  module ActiveRecordDoctor
    class UnindexedDeletedAtRunner < ::Inquisition::Runner
      include RunnerHelper

      def call
        perform(::ActiveRecordDoctor::Tasks::UnindexedDeletedAt)
      end

      def warning_message
        'unindexed deleted at'
      end
    end
  end
end
