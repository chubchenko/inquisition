RSpec.describe Inquisition::Fasterer::Runner do
  describe '#call' do
    subject(:subject_call_class) { described_class.call }

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
        allow(offense_collector).to receive(:any?).and_return(true)
        allow(offense_collector).to receive(:instance_variable_get).and_return(offense)
      end

      it 'return errors' do
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVEL_LOW,
          line: offense.first.line_number,
          runner: be_kind_of(described_class),
          file: instance_analyzer.file_path,
          message: offense.first.explanation
        ).and_call_original
        expect(subject_call_class.first).to be_kind_of(Inquisition::Issue)
        expect(subject_call_class.count).to eq(1)
      end
    end

    context 'when call without errors' do
      let(:instance_analyzer) { instance_double(Fasterer::Analyzer, file_path: test_file, errors: []) }

      it 'not return errors' do
        expect(subject_call_class).to be_empty
      end
    end
  end
end
