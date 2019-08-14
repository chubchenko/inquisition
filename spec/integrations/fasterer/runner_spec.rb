RSpec.describe Inquisition::Fasterer::Runner do
  describe '#call' do
    context 'when runner return errors' do
      subject(:call_runner) { described_class.new.call }

      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/fasterer/errors.yml') }

      before { allow(Rails).to receive(:root).and_return('./spec/dummy') }

      it 'return issue with current arguments' do
        expect(call_runner).to match_array(
          errors.map do |error|
            Inquisition::Issue.new(
              severity: :low,
              line: error['line'],
              runner: be_kind_of(described_class),
              path: error['file'],
              message: error['message']
            )
          end
        )
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
