RSpec.describe Inquisition::Fasterer::Runner do
  describe '#call' do
    context 'when runner return errors' do
      subject(:call_runner) { described_class.new.call }

      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/errors.yml')['fasterer'] }

      before { stub_const('Inquisition::Fasterer::Runner::APP_PATH', './spec/dummy') }

      it 'return issue with current arguments' do
        allow(Inquisition::Issue).to receive(:new)
        call_runner
        errors.each do |error|
          expect(Inquisition::Issue).to have_received(:new).with(
            severity: :low,
            line: error['line'],
            runner: be_kind_of(described_class),
            path: error['file'],
            message: error['message']
          )
        end
      end

      it 'return type issues' do
        expect(call_runner).to all(be_kind_of(Inquisition::Issue))
      end

      it 'return count issues' do
        expect(call_runner.count).to eq(1)
      end
    end
  end
end
