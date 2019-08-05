RSpec.describe Inquisition::Brakeman::Runner do
  include_examples 'enablable', 'brakeman'

  describe '#call' do
    subject(:runner) { described_class.new }

    let(:message) do
      instance_double(Brakeman::Messages::Message, to_s: 'Potentially dangerous key allowed for mass assignment')
    end
    let(:warning) do
      instance_double(
        Brakeman::Warning,
        confidence: confidence,
        line: 42,
        relative_path: 'app/controllers/users_controller.rb',
        message: message
      )
    end
    let(:issue) do
      Inquisition::Issue.new(
        path: warning.relative_path, line: warning.line, severity: severity, message: message.to_s, runner: nil
      )
    end

    before do
      allow(Brakeman).to receive(:run)
        .with(app_path: '.')
        .and_return(instance_double(Brakeman::Tracker, warnings: [warning]))
    end

    context 'when warning confidence is 0' do
      let(:confidence) { 0 }
      let(:severity) { Inquisition::Severity::HIGH }

      it { expect(runner.call).to contain_exactly(issue) }
    end

    context 'when warning confidence is 1' do
      let(:confidence) { 1 }
      let(:severity) { Inquisition::Severity::MEDIUM }

      it { expect(runner.call).to contain_exactly(issue) }
    end

    context 'when warning confidence is 2' do
      let(:confidence) { 2 }
      let(:severity) { Inquisition::Severity::LOW }

      it { expect(runner.call).to contain_exactly(issue) }
    end
  end
end
