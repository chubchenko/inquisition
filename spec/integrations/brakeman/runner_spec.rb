RSpec.describe Inquisition::Brakeman::Runner do
  describe '#call' do
    let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/errors.yml')['brakeman'] }

    before { stub_const('Inquisition::Brakeman::Runner::APP_PATH', './spec/dummy') }

    it 'return issue type object' do
      expect(described_class.call).to all(be_kind_of(Inquisition::Issue))
    end

    it 'return count issues' do
      expect(described_class.call.count).to eq(1)
    end

    it 'return issue with arguments' do
      allow(Inquisition::Issue).to receive(:new)
      described_class.call
      errors.each do |error|
        expect(Inquisition::Issue).to have_received(:new).with(
          level: error['level'],
          line: error['line'],
          runner: be_kind_of(described_class),
          file: error['file'],
          message: error['message']
        )
      end
    end
  end
end
