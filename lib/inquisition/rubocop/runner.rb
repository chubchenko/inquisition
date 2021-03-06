module Inquisition
  module Rubocop
    class Runner < ::Inquisition::Runner
      attr_reader :modified_runner

      def call
        @modified_runner = RubocopModifiedRunner.new({}, ::Inquisition::Rubocop.configuration)
        offenses = modified_runner.run([Rails.root.to_s])
        offenses.each { |offense| create_issues(offense) }
        @issues
      end

      private

      def create_issues(offenses)
        offenses.values.flatten.each do |offense|
          @issues << Inquisition::Issue.new(Issue.new(offenses.keys[0], offense).to_h.merge(runner: self))
        end
      end
    end
  end
end
