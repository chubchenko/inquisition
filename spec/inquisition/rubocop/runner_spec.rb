RSpec.describe Inquisition::Rubocop::Runner do
  include_examples 'enablable', :rubocop

  describe '#call' do
    let(:runner) { described_class.new }
    let(:message) { 'Warn message' }
    let(:file) { 'foo/bar.rb' }

    let(:convention_offense) do
      instance_double(
        RuboCop::Cop::Offense,
        severity: instance_double(RuboCop::Cop::Severity, name: :convention),
        message: message,
        line: 1,
        cop_name: 'Security/Eval',
        status: :unsupported
      )
    end

    let(:warning_offense) do
      instance_double(
        RuboCop::Cop::Offense,
        severity: instance_double(RuboCop::Cop::Severity, name: :warning),
        message: message,
        line: 2,
        cop_name: 'Metrics/LineLength',
        status: :unsupported
      )
    end

    let(:error_offense) do
      instance_double(
        RuboCop::Cop::Offense,
        severity: instance_double(RuboCop::Cop::Severity, name: :error),
        message: message,
        line: 3,
        cop_name: 'Metrics/BlockLength',
        status: :unsupported
      )
    end

    let(:low_severity_issue) do
      Inquisition::Issue.new(
        severity: Inquisition::Severity::LOW,
        path: file,
        message: message,
        line: 1,
        runner: nil,
        context: :unsupported
      )
    end

    let(:medium_severity_issue) do
      Inquisition::Issue.new(
        severity: Inquisition::Severity::MEDIUM,
        path: file,
        message: message,
        line: 2,
        runner: nil,
        context: :unsupported
      )
    end

    let(:high_severity_issue) do
      Inquisition::Issue.new(
        severity: Inquisition::Severity::HIGH,
        path: file,
        message: message,
        line: 3,
        runner: nil,
        context: :unsupported
      )
    end

    let(:offenses) { [{ file => [convention_offense] }, { file => [warning_offense] }, { file => [error_offense] }] }
    let(:issues) { [low_severity_issue, medium_severity_issue, high_severity_issue] }
    let(:rubocop) { instance_double(Inquisition::Rubocop::RubocopModifiedRunner) }

    before do
      allow(Inquisition::Rubocop::RubocopModifiedRunner).to receive(:new).and_return(rubocop)
      allow(rubocop).to receive(:run).and_return(offenses)
    end

    it 'returns array with issues' do
      expect(runner.call).to match_array(issues)
    end
  end
end
