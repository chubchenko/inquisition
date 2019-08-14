require 'brakeman/scanner'

RSpec.describe Inquisition::Brakeman::Runner do
  describe '#call' do
    subject(:call_runner) { described_class.new.call }

    let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/brakeman/errors.yml') }

    it 'returns issues with arguments' do
      expect(call_runner).to match_array(
        errors.map do |error|
          Inquisition::Issue.new(
            severity: :high,
            line: error['line'],
            runner: be_kind_of(described_class),
            path: error['file'],
            message: error['message']
          )
        end
      )
    end
  end
end
