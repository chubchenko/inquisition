RSpec.describe Inquisition::Rubocop::Runner do
  describe '#call' do
    subject(:call_runner) { described_class.new.call }

    context 'when dummy runner return issues' do
      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/errors.yml')['rubocop'] }

      before { allow(Rails).to receive(:root).and_return('./spec/dummy') }

      it 'return issue with current arguments' do
        allow(Inquisition::Issue).to receive(:new)
        call_runner
        errors.each do |error|
          expect(Inquisition::Issue).to have_received(:new).with(
            severity: :low,
            path: error['file'],
            message: error['message'],
            runner: be_kind_of(described_class),
            line: error['line']
          )
        end
      end
    end
  end
end
