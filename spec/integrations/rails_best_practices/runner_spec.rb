RSpec.describe Inquisition::RailsBestPractices::Runner do
  describe '#call' do
    subject(:call_runner) { described_class.new.call }

    context 'when call runner and it return errors' do
      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/rails_best_practices/errors.yml') }

      it 'return issue with current arguments' do
        expect(call_runner).to match_array(
          errors.map do |error|
            Inquisition::Issue.new(
              severity: :low,
              line: error['line'],
              runner: be_kind_of(described_class),
              path: File.join(Dir.pwd, error['file']),
              message: error['message']
            )
          end
        )
      end
    end
  end
end
