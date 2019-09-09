RSpec.describe Inquisition::Bundler::Audit::Runner do
  include_examples 'enablable', 'bundler_audit'

  describe '#call' do
    subject(:runner) { described_class.new }

    let(:scanner) { instance_double(Bundler::Audit::Scanner) }

    before do
      allow(Bundler::Audit::Scanner).to receive(:new).with(Rails.root).and_return(scanner)
      allow(Bundler::Audit::Database).to receive(:update!).with(quiet: true).and_return(true)
    end

    context 'when there are no issues' do
      before do
        allow(scanner).to receive(:scan).and_return([].to_enum)
      end

      it { expect(runner.call).to be_empty }

      it 'updates the ruby-advisory-db' do
        runner.call

        expect(Bundler::Audit::Database).to have_received(:update!).with(quiet: true)
      end
    end

    context 'when there is insecure source' do
      let(:issue) do
        Inquisition::Issue.new(
          path: nil,
          line: nil,
          severity: Inquisition::Severity::MEDIUM,
          category: :security,
          message: 'Insecure Source URI found: http://rubygems.org/',
          runner: runner
        )
      end
      let(:insecure_source) do
        Bundler::Audit::Scanner::InsecureSource.new('http://rubygems.org/')
      end

      before do
        allow(scanner).to receive(:scan).and_return(
          [insecure_source].to_enum
        )
      end

      it 'returns a collection of issues' do
        expect(runner.call).to contain_exactly(issue)
      end

      it 'updates the ruby-advisory-db' do
        runner.call

        expect(Bundler::Audit::Database).to have_received(:update!).with(quiet: true)
      end
    end

    context 'when there is unpatched gem' do
      let(:issue) do
        Inquisition::Issue.new(
          path: nil,
          line: nil,
          severity: Inquisition::Severity::MEDIUM,
          category: :security,
          message: 'Nested attributes rejection proc bypass in Active Record',
          runner: runner
        )
      end
      let(:gem) { instance_double(Bundler::LazySpecification) }
      let(:advisory) do
        instance_double(Bundler::Audit::Advisory, criticality: :medium,
                                                  title: 'Nested attributes rejection proc bypass in Active Record')
      end
      let(:unpatched_gem) do
        Bundler::Audit::Scanner::UnpatchedGem.new(gem, advisory)
      end

      before do
        allow(scanner).to receive(:scan).and_return(
          [unpatched_gem].to_enum
        )
      end

      it 'returns a collection of issues' do
        expect(runner.call).to contain_exactly(issue)
      end

      it 'updates the ruby-advisory-db' do
        runner.call

        expect(Bundler::Audit::Database).to have_received(:update!).with(quiet: true)
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
