RSpec.describe Inquisition::LolDba::Runner do
  describe '#call' do
    subject(:call_runner) { described_class.new.call }

    context 'when call runner with errors' do
      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/lol_dba/errors.yml') }

      it 'return index errors' do
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
