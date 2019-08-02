RSpec.describe Inquisition::Fasterer::Runner do
  describe '#call' do
    context 'when runner return errors' do
      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/errors.yml')['fasterer'] }

      before { stub_const('Inquisition::Fasterer::Runner::APP_PATH', './spec/dummy') }

      it 'return issue with current arguments' do
        allow(Inquisition::Issue).to receive(:new)
        described_class.call
        errors.each do |error|
          expect(Inquisition::Issue).to have_received(:new).with(
            level: Inquisition::Issue::LEVELS[:low],
            line: error['line'],
            runner: be_kind_of(described_class),
            file: error['file'],
            message: error['message']
          )
        end
      end

      it 'return type issues' do
        expect(described_class.call).to all(be_kind_of(Inquisition::Issue))
      end

      it 'return count issues' do
        expect(described_class.call.count).to eq(1)
      end
    end
  end
end
