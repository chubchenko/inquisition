RSpec.describe Inquisition::Bundler::Leak::Runner do
  include_examples 'enablable', 'bundler_leak'

  describe '#call' do
    subject(:runner) { described_class.new }

    let(:scanner) { instance_double(Bundler::Plumber::Scanner) }

    before do
      allow(Bundler::Plumber::Scanner).to receive(:new).with(Rails.root).and_return(scanner)
      allow(Bundler::Plumber::Database).to receive(:update!).with(quiet: true).and_return(true)
    end

    context 'when there are no issues' do
      before do
        allow(scanner).to receive(:scan).and_return([].to_enum)
      end

      it { expect(runner.call).to be_empty }
    end

    context 'when there is unpatched gem' do
      let(:test_gem) { instance_double(Bundler::LazySpecification) }
      let(:advisory) { instance_double(Bundler::Plumber::Advisory, title: 'Memory leak in formatter middleware') }
      let(:unpatched_gem) { Bundler::Plumber::Scanner::UnpatchedGem.new(test_gem, advisory) }

      let(:issue) do
        Inquisition::Issue.new(
          line: nil,
          category: Inquisition::Category::PERFORMANCE,
          severity: Inquisition::Severity::LOW,
          path: Inquisition::Bundler::Leak::Vulnerability::GEMFILE,
          message: 'Memory leak in formatter middleware',
          runner: nil
        )
      end

      before do
        allow(scanner).to receive(:scan).and_return([unpatched_gem].to_enum)
      end

      it do
        expect(runner.call).to match_array([issue])
        expect(Bundler::Plumber::Database).to have_received(:update!).with(quiet: true)
      end
    end

    context 'when there is unsupported issue' do
      before do
        allow(scanner).to receive(:scan).and_return(
          [OpenStruct.new].to_enum
        )
      end

      it { expect { runner.call }.to raise_error(ArgumentError, 'Unknown type: OpenStruct') }
    end
  end
end
