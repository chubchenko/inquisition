RSpec.describe Inquisition::Rubycritic::Runner do
  describe '#call' do
    subject(:call_runner) { described_class.new.call }

    context 'when runner returns errors' do
      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/rubycritic/errors.yml') }

      before { allow(Rails).to receive(:root).and_return('./spec/dummy') }

      it 'return issue with current arguments' do
        expect(call_runner).to match_array(
          errors.map do |error|
            Inquisition::Issue.new(
              severity: :low,
              line: error['line'],
              runner: be_kind_of(described_class),
              path: Pathname(error['file']),
              message: error['message']
            )
          end
        )
      end
    end
  end
end
