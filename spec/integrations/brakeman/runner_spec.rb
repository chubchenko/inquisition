require 'brakeman/scanner'

RSpec.describe Inquisition::Brakeman::Runner do
  describe '#call' do
    subject(:call_runner) { described_class.new.call }

    let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/errors.yml')['brakeman'] }

    before { allow(Rails).to receive(:root).and_return('./spec/dummy') }

    it 'returns issues with arguments' do
      allow(Inquisition::Issue).to receive(:new)
      call_runner
      errors.each do |error|
        expect(Inquisition::Issue).to have_received(:new).with(
          severity: :high,
          line: error['line'],
          runner: be_kind_of(described_class),
          path: error['file'],
          message: error['message']
        )
      end
    end
  end
end
