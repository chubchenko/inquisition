RSpec.describe Inquisition::RailsBestPractices::Runner do
  include_examples 'enablable', :rails_best_practices

  describe '#call' do
    subject(:runner) { described_class.new }

    let(:analyzer) { instance_double(RailsBestPractices::Analyzer) }

    before do
      allow(analyzer).to receive(:analyze)
      allow(RailsBestPractices::Analyzer).to receive(:new).with(Rails.root, 'silent' => true).and_return(analyzer)
    end

    context 'when there are no issues' do
      before do
        allow(analyzer).to receive(:errors).and_return([])
      end

      it { expect(runner.call).to be_empty }
    end

    context 'when there is at least 1 issue' do
      let(:issue) do
        Inquisition::Issue.new(
          path: 'config/initializers/backtrace_silencers.rb',
          line: 6,
          severity: Inquisition::Severity::LOW,
          message: 'Line is longer than 111 characters (112 characters)',
          category: Inquisition::Category::STYLE,
          runner: runner
        )
      end
      let(:error) do
        instance_double(RailsBestPractices::Core::Error,
                        short_filename: 'config/initializers/backtrace_silencers.rb',
                        line_number: '6',
                        message: 'line is longer than 111 characters (112 characters)',
                        type: 'RailsBestPractices::Lexicals::LongLineCheck')
      end

      before { allow(analyzer).to receive(:errors).and_return([error]) }

      it 'returns a collection of issues' do
        expect(runner.call).to contain_exactly(issue)
      end
    end
  end
end
