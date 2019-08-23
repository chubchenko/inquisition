RSpec.shared_examples 'runner' do |fixture_name|
  subject(:runner) { described_class.new }

  describe '#call' do
    let(:data) { file_fixture(fixture_name).read }

    it 'returns a collection of issues' do
      expect(runner.call).to match_array(
        Psych.load(data).map do |item|
          Inquisition::Issue.new(
            path: item['path'],
            line: item['line'],
            severity: item['severity'],
            category: item['category'],
            message: item['message'],
            runner: runner
          )
        end
      )
    end
  end
end
