module Inquisition
  module ActiveRecordDoctor
    class Runner < ::Inquisition::Runner
      RUNNERS = %w[ExtraneousIndexesRunner
                   MissingForeignKeysRunner
                   MissingNonNullConstraintRunner
                   MissingPresenceValidationRunner
                   MissingUniqueIndexesRunner
                   UndefinedTableReferencesRunner
                   UnindexedDeletedAtRunner
                   UnindexedForeignKeysRunner].freeze

      def call
        RUNNERS.each do |runner|
          runner = "Inquisition::ActiveRecordDoctor::#{runner}".constantize.new
          runner.run
          issues = runner.issues

          issues.each { |issue| @issues << Inquisition::Issue.new(issue) }
        end
        @issues
      end
    end
  end
end
