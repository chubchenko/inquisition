


require 'pry'

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

  let(:low_level_issue) { { level: Inquisition::Issue::LEVELS[:low], file: file, message: message } }
  let(:medium_level_issue) { { level: Inquisition::Issue::LEVELS[:medium], file: file, message: message } }
  let(:high_level_issue) { { level: Inquisition::Issue::LEVELS[:high], file: file, message: message } }

  let(:offenses) { [{ file => [convention_offense] }, { file => [warning_offense] }, { file => [error_offense] }] }
  let(:issues) { [low_level_issue, medium_level_issue, high_level_issue] }
  let(:rubocop) { instance_double(Inquisition::RuboCop::RuboCopModifiedRunner) }

  let(:user_config) { Inquisition::RuboCop::Runner::USERS_CONFIG_FILE }
  let(:default_config) { 'inquisition/lib/config/.rubocop.yml' }

  describe '#choose_config' do
    context 'with users config file' do
      before { allow(File).to receive(:exist?).with(user_config).and_return(true) }

      it 'returns users config' do
        expect(runner.send(:choose_config)).to eq(user_config)
        expect(File).to have_received(:exist?).with(user_config)
      end
    end

    context 'without users config file' do
      before { allow(File).to receive(:exist?).with(user_config).and_return(false) }

      it 'returns default config' do
        expect(runner.send(:choose_config)).to include(default_config)
        expect(File).to have_received(:exist?).with(user_config)
      end
    end
  end

  describe '#call' do
    before do
      allow(Inquisition::RuboCop::RuboCopModifiedRunner).to receive(:new).and_return(rubocop)
      allow(rubocop).to receive(:run).and_return(offenses)
    end

    it 'returns array with issues' do
      runner.call.each_with_index do |issue, index|
        expect(issue.instance_variable_get(:@level)).to eq(issues[index][:level])
        expect(issue.instance_variable_get(:@file)).to eq(issues[index][:file])
        expect(issue.instance_variable_get(:@message)).to eq(issues[index][:message])
      end
      expect(Inquisition::RuboCop::RuboCopModifiedRunner).to have_received(:new)
      expect(rubocop).to have_received(:run)
    end
  end
end
