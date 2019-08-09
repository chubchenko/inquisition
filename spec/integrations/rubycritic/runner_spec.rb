RSpec.describe Inquisition::Rubycritic::Runner do
  describe '#call' do
    subject(:call_runner) { described_class.new.call }

    context 'when runner returns errors' do
      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/errors.yml')['rubycritic'] }

      before { allow(Rails).to receive(:root).and_return('./spec/dummy') }

      it 'return count issue' do
        expect(call_runner.count).to eq(12)
      end

      it 'return issue' do
        expect(call_runner).to all(be_kind_of(Inquisition::Issue))
      end

      it 'return issue with current arguments' do
        allow(Inquisition::Issue).to receive(:new)
        call_runner
        errors.each do |error|
          expect(Inquisition::Issue).to have_received(:new).with(
            severity: :low,
            line: error['line'],
            runner: be_kind_of(described_class),
            path: Pathname(error['file']),
            message: error['message']
          )
        end
      end
    end
  end
end
