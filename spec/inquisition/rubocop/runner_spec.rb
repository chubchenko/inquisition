require 'pry'

RSpec.describe Inquisition::RuboCop::Runner do
  let(:runner) { described_class.new }
  let(:message) { 'Warn message' }
  let(:file) { 'foo/bar.rb' }

  let(:convention_severity) { instance_double(RuboCop::Cop::Severity, name: :convention) }
  let(:warning_severity)    { instance_double(RuboCop::Cop::Severity, name: :warning) }
  let(:error_severity)      { instance_double(RuboCop::Cop::Severity, name: :error) }

  let(:convention_offense) do
    instance_double(RuboCop::Cop::Offense, severity: convention_severity, message: message, line: nil)
  end

  let(:warning_offense) do
    instance_double(RuboCop::Cop::Offense, severity: warning_severity, message: message, line: nil)
  end

  let(:error_offense) do
    instance_double(RuboCop::Cop::Offense, severity: error_severity, message: message, line: nil)
  end

  let(:offenses) { [[file, [convention_offense]], [file, [warning_offense]], [file, [error_offense]]] }

  let(:high_level_issue) do
    Inquisition::Issue.new(level: Inquisition::Issue::LEVELS[:high], file: file,
                           line: nil, message: message, runner: nil)
  end

  let(:medium_level_issue) do
    Inquisition::Issue.new(level: Inquisition::Issue::LEVELS[:medium], file: file,
                           line: nil, message: message, runner: nil)
  end

  let(:low_level_issue) do
    Inquisition::Issue.new(level: Inquisition::Issue::LEVELS[:low], file: file,
                           line: nil, message: message, runner: nil)
  end

  let(:issues) { [low_level_issue, medium_level_issue, high_level_issue] }

  describe '#call' do
    before do
      rubocop = instance_double(RuboCop::Runner)
      allow(rubocop).to receive(:run).and_return(offenses)
      allow(Inquisition::RuboCop::RuboCopPatcher).to receive(:new).and_return(rubocop)
    end

    it 'returns array with issues' do
      runner.call.each_with_index do |issue, index|
        expect(issue.instance_variable_get(:@level)).to eq(issues[index].instance_variable_get(:@level))
        expect(issue.instance_variable_get(:@file)).to eq(issues[index].instance_variable_get(:@file))
        expect(issue.instance_variable_get(:@message)).to eq(issues[index].instance_variable_get(:@message))
      end
    end
  end
end
