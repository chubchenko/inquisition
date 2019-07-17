module Inquisition
  module ActiveRecordDoctor
    class MissingForeignKeysRunner < ::Inquisition::Runner
      include RunnerHelper

      def call
        perform(::ActiveRecordDoctor::Tasks::MissingForeignKeys)
      end

      def warning_message
        'missing foreign keys'
      end
    end
  end
end
