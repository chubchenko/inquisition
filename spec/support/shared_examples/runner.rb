RSpec.shared_examples 'runner' do |fixture_name|
  subject(:runner) { described_class.new }

  describe '#call' do
    let(:data) { file_fixture(fixture_name).read }
    let(:issues) do
      Psych.load(data).map do |item|
        Inquisition::Issue.new(
          path: item['path'],
          line: item['line'],
          severity: item['severity'],
          message: item['message'],
          runner: runner
        )
      end
    end

    it 'returns a collection of issues' do
      expect(runner.call).to match_array(issues)
    end
  end
end
