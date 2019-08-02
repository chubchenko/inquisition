RSpec.describe Inquisition::Rubycritic::Runner do
  describe '#call' do
    subject(:result_runner) { described_class.call }

    context 'when runner returns errors' do
      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/errors.yml')['rubycritic'] }

      before { stub_const('Inquisition::Rubycritic::Runner::APP_PATH', './spec/dummy') }

      it 'return count issue' do
        expect(result_runner.count).to eq(12)
      end

      it 'return issue' do
        expect(result_runner).to all(be_kind_of(Inquisition::Issue))
      end

      it 'return issue with current arguments' do
        allow(Inquisition::Issue).to receive(:new)
        result_runner
        errors.each do |error|
          expect(Inquisition::Issue).to have_received(:new).with(
            level: Inquisition::Issue::LEVELS[:low],
            line: error['line'],
            runner: be_kind_of(described_class),
            file: Pathname(error['file']),
            message: error['message']
          )
        end
      end
    end
  end
end
