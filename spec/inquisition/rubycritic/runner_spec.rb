RSpec.describe Inquisition::Rubycritic::Runner do
  include_examples 'enablable', 'rubycritic'

  describe '#call' do
    subject(:result_runner) { described_class.new.call }

    let(:analyse_module_without_errors) { [instance_double('RubyCritic::AnalysedModule', smells: [])] }
    let(:analyser_reek) { instance_double(Inquisition::Rubycritic::Analysers::Reek) }
    let(:analyser_flay) { instance_double(Inquisition::Rubycritic::Analysers::Flay) }
    let(:analyser_flog) { instance_double(Inquisition::Rubycritic::Analysers::Flog) }
    let(:smell) { instance_double('RubyCritic::Smell', locations: [smell_location], message: 'test message') }
    let(:smell_location) { instance_double('RubyCritic::Location', line: 1, pathname: pathname) }
    let(:pathname) do
      Rails.root + 'app/controllers/application_controller.rb'
    end

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

      it 'returns a collection of issues' do
        expect(result_runner).to contain_exactly(
          Inquisition::Issue.new(
            severity: :low,
            path: 'app/controllers/application_controller.rb',
            line: smell_location.line,
            runner: nil,
            message: smell.message
          )
        )
      end
    end

    context 'when runner success' do
      let(:analyse_module) { [instance_double('RubyCritic::AnalysedModule', smells: [])] }

      it { is_expected.to be_empty }
    end
  end
end
