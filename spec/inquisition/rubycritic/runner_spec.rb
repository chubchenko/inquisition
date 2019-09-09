RSpec.describe Inquisition::Rubycritic::Runner do
  include_examples 'enablable', 'rubycritic'

  describe '#call' do
    subject(:runner_result) { described_class.new.call }

    let(:analyser_reek) { instance_double(Inquisition::Rubycritic::Analysers::Reek) }
    let(:analyser_flay) { instance_double(Inquisition::Rubycritic::Analysers::Flay) }
    let(:analyser_flog) { instance_double(Inquisition::Rubycritic::Analysers::Flog) }

    let(:smell) { instance_double(RubyCritic::Smell, locations: [smell_location], message: 'test message') }
    let(:smell_location) { instance_double(RubyCritic::Location, line: 1, pathname: Rails.root + pathname) }
    let(:pathname) { 'app/controllers/application_controller.rb' }

    before do
      allow(Inquisition::Rubycritic::Analysers::Reek).to receive(:new).and_return(analyser_reek)
      allow(Inquisition::Rubycritic::Analysers::Flay).to receive(:new).and_return(analyser_flay)
      allow(Inquisition::Rubycritic::Analysers::Flog).to receive(:new).and_return(analyser_flog)

      [analyser_reek, analyser_flay, analyser_flog].each do |analyser|
        allow(analyser).to receive(:run).and_return(analysed_module)
      end
    end

    context 'when runner returns errors' do
      let(:analysed_module) { [instance_double(RubyCritic::AnalysedModule, smells: [smell])] }
      let(:duplication_issue) do
        Inquisition::Issue.new(
          severity: Inquisition::Severity::LOW,
          category: :duplication,
          path: pathname,
          line: smell_location.line,
          runner: nil,
          message: smell.message
        )
      end

      let(:complexity_issue) do
        Inquisition::Issue.new(
          severity: Inquisition::Severity::LOW,
          category: :complexity,
          path: pathname,
          line: smell_location.line,
          runner: nil,
          message: smell.message
        )
      end

      it { is_expected.to match_array([duplication_issue, complexity_issue, complexity_issue]) }
    end

    context 'when runner success' do
      let(:analysed_module) { [instance_double(RubyCritic::AnalysedModule, smells: [])] }

      it { is_expected.to be_empty }
    end
  end
end
