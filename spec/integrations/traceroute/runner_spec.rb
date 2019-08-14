RSpec.describe Inquisition::Traceroute::Runner do
  describe '#call' do
    subject(:call_runner) { described_class.new.call }

    context 'when call runner in dummy' do
      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/traceroute/errors.yml') }

      it 'return issues with current arguments' do
        expect(call_runner).to match_array(
          errors.map do |error|
            Inquisition::Issue.new(
              severity: :low,
              line: nil,
              runner: be_kind_of(described_class),
              path: nil,
              message: error['message']
            )
          end
        )
      end
    end
  end
end
