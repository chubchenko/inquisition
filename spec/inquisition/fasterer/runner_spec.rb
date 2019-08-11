RSpec.describe Inquisition::Fasterer::Runner do
  include_examples 'enablable', 'fasterer'

  describe '#call' do
    subject(:runner_result) { described_class.new.call }

    let(:test_file) { 'app/controllers/application_controller.rb' }
    let(:instance_file_traverser) { instance_double(Fasterer::FileTraverser) }
    let(:instance_analyzer) { instance_double(Fasterer::Analyzer, file_path: "#{Rails.root}/#{test_file}", errors: offense_collector) }
    let(:offense_collector) { instance_double('Fasterer::Analyzer::OffenseCollector', offenses: offense) }
    let(:offense) { [instance_double(Fasterer::Offense, explanation: 'error', line_number: 1)] }

    before do
      allow(Fasterer::FileTraverser).to receive(:new).and_return(instance_file_traverser)
      allow(instance_file_traverser).to receive(:scannable_files).and_return(["#{Rails.root}/#{test_file}"])
      allow(Fasterer::Analyzer).to receive(:new).and_return(instance_analyzer)
      allow(instance_analyzer).to receive(:scan).and_return(nil)
    end

    context 'when call with errors' do
      before do
        allow(instance_analyzer).to receive(:errors).and_return(offense)
        allow(instance_file_traverser).to receive(:offenses_grouped_by_type).and_return({ error: offense_collector })
      end

      it 'returns a collection of issues' do
        expect(runner_result).to contain_exactly(Inquisition::Issue.new(
          severity: :low,
          line: offense.first.line_number,
          path: test_file,
          message: offense.first.explanation,
          runner: nil
        )
      )
      end
    end

    context 'when call without errors' do
      let(:instance_analyzer) { instance_double(Fasterer::Analyzer, file_path: test_file, errors: []) }

      before do
        allow(instance_file_traverser).to receive(:offenses_grouped_by_type).and_return({})
      end

      it { is_expected.to be_empty }
    end
  end
end
