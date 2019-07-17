module Inquisition
  module ActiveRecordDoctor
    class ExtraneousIndexesRunner < ::Inquisition::Runner
      include RunnerHelper

      def call
        perform(::ActiveRecordDoctor::Tasks::ExtraneousIndexes)
      end

      def warning_message
        'extraneous indexes'
      end
    end
  end
end
