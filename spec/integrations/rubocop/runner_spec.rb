RSpec.describe Inquisition::RuboCop::Runner do
  describe '#call' do
    context 'when dummy runner return issues' do
      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/errors.yml')['rubocop'] }

      before { stub_const('Inquisition::RuboCop::Runner::APP_PATH', './spec/dummy') }

      it 'return issue' do
        expect(described_class.call).to all(be_kind_of(Inquisition::Issue))
      end

      it 'return count issues' do
        expect(described_class.call.count).to eq(3)
      end

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
    end
  end
end
