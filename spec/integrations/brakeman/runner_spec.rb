RSpec.describe Inquisition::Brakeman::Runner do
  describe '#call' do
    subject(:call_runner) { described_class.new.call }

    let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/errors.yml')['brakeman'] }

    before { stub_const('Inquisition::Brakeman::Runner::APP_PATH', './spec/dummy') }

    it 'returns ...' do
      expect(call_runner).to contain_exactly(
        Issue.new(
          severity: error['level'],
          path: error['file'],
          line: error['line'],
          message: error['message'],
          runner: nil
        )
      )
    end
  end
end
