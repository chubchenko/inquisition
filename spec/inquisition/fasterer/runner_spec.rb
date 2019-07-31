RSpec.describe Inquisition::Fasterer::Runner do
  describe '#call' do
    subject(:runner_result) { described_class.call }

    let(:test_file) { 'test_file_path' }
    let(:instance_file_traverser) { instance_double(Fasterer::FileTraverser) }
    let(:instance_analyzer) { instance_double(Fasterer::Analyzer, file_path: test_file, errors: offense_collector) }
    let(:offense_collector) { instance_double('Fasterer::Analyzer::OffenseCollector', offenses: offense) }
    let(:offense) { [instance_double(Fasterer::Offense, explanation: 'error', line_number: 1)] }

    before do
      allow(Fasterer::FileTraverser).to receive(:new).and_return(instance_file_traverser)
      allow(instance_file_traverser).to receive(:scannable_files).and_return([test_file])
      allow(Fasterer::Analyzer).to receive(:new).and_return(instance_analyzer)
      allow(instance_analyzer).to receive(:scan).and_return(nil)
    end

    context 'when call with errors' do
      before do
        allow(instance_analyzer).to receive(:errors).and_return(offense)
      end

      it 'return issue with current arguments' do
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low], line: offense.first.line_number, runner: be_kind_of(described_class),
          file: instance_analyzer.file_path, message: offense.first.explanation
        ).and_call_original
        runner_result
      end

      it 'return issue' do
        expect(runner_result.first).to be_kind_of(Inquisition::Issue)
      end

      it 'return count issues' do
        expect(runner_result.count).to eq(1)
      end
    end

    context 'when call without errors' do
      let(:instance_analyzer) { instance_double(Fasterer::Analyzer, file_path: test_file, errors: []) }

      it 'not return errors' do
        is_expected.to be_empty
      end
    end
  end
end
