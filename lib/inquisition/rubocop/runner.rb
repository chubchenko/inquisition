require 'rubocop'

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
        issues = RuboCopModifiedRunner.new({}, Configuration.call).run(['.'])
        issues.map do |path, offense|
          binding.pry
          # issues_for(issue)
        end
        # offenses.each { |offense| issues_for(offense) }
        # @issues
      end

      private

      def issues_for(offenses1)
        # offenses.values.flatten.each do |offense|
        #   @issues << Inquisition::Issue.new(
        #     severity: LEVELS[offense.severity.name],
        #     path: offenses.keys[0],
        #     message: offense.message,
        #     runner: self,
        #     line: offense.line)
        # end
        offenses1.each do |path, offenses|
          offenses.each do |offense|
            @issues << Issue.new(
              severity: LEVELS[offense.severity.name],
              path: path,
              message: offense.message,
              line: offense.line,
              runner: self
            )
          end
        end
      end
    end
  end
end
