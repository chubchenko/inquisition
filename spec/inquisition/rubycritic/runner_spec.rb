RSpec.describe Inquisition::Rubycritic::Runner do
  describe '#call' do
    subject(:result_runner) { described_class.new.call }

    let(:analyse_module_without_errors) { [instance_double('RubyCritic::AnalysedModule', smells: [])] }
    let(:analyser_reek) { instance_double(Inquisition::Rubycritic::Analysers::Reek) }
    let(:analyser_flay) { instance_double(Inquisition::Rubycritic::Analysers::Flay) }
    let(:analyser_flog) { instance_double(Inquisition::Rubycritic::Analysers::Flog) }
    let(:smell) { instance_double('RubyCritic::Smell', locations: [smell_location], message: 'test message') }
    let(:smell_location) { instance_double('RubyCritic::Location', line: 1, pathname: 'test_path') }

    before do
      allow(Inquisition::Rubycritic::Analysers::Reek).to receive(:new).and_return(analyser_reek)
      allow(Inquisition::Rubycritic::Analysers::Flay).to receive(:new).and_return(analyser_flay)
      allow(Inquisition::Rubycritic::Analysers::Flog).to receive(:new).and_return(analyser_flog)
      allow(analyser_reek).to receive(:run).and_return(analyse_module)
      allow(analyser_flay).to receive(:run).and_return(analyse_module_without_errors)
      allow(analyser_flog).to receive(:run).and_return(analyse_module_without_errors)
    end

    context 'when runner returns errors' do
      let(:analyse_module) { [instance_double('RubyCritic::AnalysedModule', smells: [smell])] }

      it 'return count issue' do
        expect(result_runner.count).to eq(1)
      end

      it 'return issue' do
        expect(result_runner.first).to be_kind_of(Inquisition::Issue)
      end

      it 'return issue with current arguments' do
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low],
          file: smell_location.pathname,
          line: smell_location.line,
          runner: be_kind_of(described_class),
          message: smell.message
        ).and_call_original
        result_runner
      end
    end

    context 'when runner success' do
      let(:analyse_module) { [instance_double('RubyCritic::AnalysedModule', smells: [])] }

      it 'do not return errors' do
        is_expected.to be_empty
      end
    end
  end
end
