RSpec.describe Inquisition::RuboCop::Runner do
  let(:runner) { described_class.new }
  let(:message) { 'Warn message' }
  let(:file) { 'foo/bar.rb' }

  let(:convention_severity) { instance_double(RuboCop::Cop::Severity, name: :convention) }
  let(:warning_severity) { instance_double(RuboCop::Cop::Severity, name: :warning) }
  let(:error_severity) { instance_double(RuboCop::Cop::Severity, name: :error) }

  let(:convention_offense) do
    instance_double(RuboCop::Cop::Offense, severity: convention_severity, message: message, line: nil)
  end

  let(:warning_offense) do
    instance_double(RuboCop::Cop::Offense, severity: warning_severity, message: message, line: nil)
  end

  let(:error_offense) do
    instance_double(RuboCop::Cop::Offense, severity: error_severity, message: message, line: nil)
  end

  let(:low_severity_issue) { { severity: :low, path: file, message: message } }
  let(:medium_severity_issue) { { severity: :medium, path: file, message: message } }
  let(:high_severity_issue) { { severity: :high, path: file, message: message } }

  let(:offenses) { [[file, [convention_offense]], [file, [warning_offense]], [file, [error_offense]]] }
  let(:issues) { [low_severity_issue, medium_severity_issue, high_severity_issue] }
  let(:rubocop) { instance_double(RuboCop::Runner) }

  describe '#call' do
    it 'returns array with issues' do
      expect(rubocop).to receive(:run).and_return(offenses)
      expect(Inquisition::RuboCop::RuboCopModifiedRunner).to receive(:new).and_return(rubocop)
      runner.call.each_with_index do |issue, index|
        # TODO: temporary commented
        # expect(issue.instance_variable_get(:@severity)).to eq(issues[index][:severity])
        expect(issue.instance_variable_get(:@path)).to eq(issues[index][:path])
        expect(issue.instance_variable_get(:@message)).to eq(issues[index][:message])
      end
    end
  end
end
