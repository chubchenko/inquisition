module Inquisition
  module Rubocop
    class Runner < ::Inquisition::Runner
      LEVELS = {
        refactor: :low,
        convention: :low,
        warning: :medium,
        error: :high,
        fatal: :high
      }.freeze

      def call
        offenses = RuboCopModifiedRunner.new({}, ::Inquisition::Rubocop.configuration).run([Rails.root.to_s])
        offenses.each { |offense| create_issues(offense) }
        @issues
      end

      private

      def create_issues(offenses)
        offenses.values.flatten.each do |offense|
          @issues << Inquisition::Issue.new(
            severity: LEVELS[offense.severity.name],
            path: offenses.keys[0],
            message: offense.message,
            runner: self,
            line: offense.line
          )
        end
      end
    end
  end
end
