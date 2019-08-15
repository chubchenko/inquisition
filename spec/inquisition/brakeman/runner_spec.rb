RSpec.describe Inquisition::Brakeman::Runner do
  include_examples 'enablable', 'brakeman'

  describe '#call' do
    subject(:runner) { described_class.new }

    let(:warning) { instance_double(Brakeman::Warning) }
    let(:issue) { Inquisition::Issue.new(options.merge(runner: nil)) }
    let(:vulnerability) { instance_double(Inquisition::Brakeman::Vulnerability, to_h: options) }
    let(:options) do
      {
        path: 'app/controllers/users_controller.rb',
        line: 42,
        severity: Inquisition::Severity::HIGH,
        message: 'Potentially dangerous key allowed for mass assignment'
      }
    end

    before do
      allow(Inquisition::Brakeman::Vulnerability).to receive(:new)
        .with(warning)
        .and_return(vulnerability)

      allow(Brakeman).to receive(:run)
        .with(app_path: Rails.root)
        .and_return(instance_double(Brakeman::Tracker, warnings: [warning]))
    end

    it 'returns a collection of issues' do
      expect(runner.call).to contain_exactly(issue)
    end
  end
end
