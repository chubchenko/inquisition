RSpec.describe Inquisition::Brakeman::Runner do
  describe '#call' do
    subject(:call_runner) { described_class.new.call }

    let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/errors.yml')['brakeman'] }

    before { stub_const('Inquisition::Brakeman::Runner::APP_PATH', './spec/dummy') }

    it 'return issue type object' do
      expect(call_runner).to all(be_kind_of(Inquisition::Issue))
    end

    it 'return count issues' do
      expect(call_runner.count).to eq(1)
    end

    it 'return issue with arguments' do
      allow(Inquisition::Issue).to receive(:new)
      call_runner
      errors.each do |error|
        expect(Inquisition::Issue).to have_received(:new).with(
          severity: error['level'],
          path: error['file'],
          line: error['line'],
          runner: be_kind_of(described_class),
          message: error['message']
        )
      end
    end
  end
end
