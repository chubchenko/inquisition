RSpec.describe Inquisition::Outputter::Doc::TPL::Security::BundlerAudit do
  describe '.call' do
    subject(:call) { described_class.call([]) }

    let(:brakeman) { instance_double(described_class) }

    it 'described class extends by simple delegator' do
      expect(described_class).to be < SimpleDelegator
    end

    context 'when calling method call' do
      before do
        allow(described_class::Collection).to receive(:new).with([])
        allow(described_class).to receive(:new).and_return(brakeman)
        described_class.call([])
      end

      it 'returns instance of Collection' do
        expect(described_class::Collection).to have_received(:new).with([])
      end
    end
  end

  describe Inquisition::Outputter::Doc::TPL::Security::BundlerAudit::Collection do
    describe '#group' do
      subject(:group) { described_class.new(issues).group }

      let(:issues) { [bundler_issue, bundler_issue_one] }
      let(:bundler_issue) do
        instance_double(Inquisition::Issue, context: gem, runner: runner, severity: severity)
      end
      let(:bundler_issue_one) { instance_double(Inquisition::Issue, context: gem, runner: runner) }
      let(:runner) { instance_double(Inquisition::Bundler::Audit::Runner) }
      let(:gem) { instance_double(Bundler::LazySpecification, name: 'test') }
      let(:severity) { instance_double(Inquisition::Severity, name: :high) }
      let(:gem_link) { Inquisition::Outputter::Doc::GemDetails::DEFAULT_GEM_LINK }
      let(:gem_details) { instance_double(Inquisition::Outputter::Doc::GemDetails, name: gem.name, link: gem_link) }
      let(:instance_runner) { ::Inquisition::Bundler::Audit::Runner.new }

      before { issues.each { |issue| allow(issue).to receive(:runner).and_return(instance_runner) } }

      it 'returns grouped bundler audit by gem name' do
        expect(group).to eq({ name: gem.name, link: gem_link } => [bundler_issue, bundler_issue_one])
      end
    end

    describe '#count' do
      subject(:count) { described_class.new(issues).count }

      let(:issues) { [bundler_issue, bundler_issue_one] }
      let(:bundler_issue) { instance_double(Inquisition::Issue, context: gem, runner: runner) }
      let(:bundler_issue_one) { instance_double(Inquisition::Issue, context: gem, runner: runner) }
      let(:runner) { instance_double(Inquisition::Bundler::Audit::Runner) }
      let(:gem) { instance_double(Bundler::LazySpecification, name: 'test') }
      let(:gem_link) { Inquisition::Outputter::Doc::GemDetails::DEFAULT_GEM_LINK }
      let(:gem_details) { instance_double(Inquisition::Outputter::Doc::GemDetails, name: gem.name, link: gem_link) }
      let(:instance_runner) { ::Inquisition::Bundler::Audit::Runner.new }

      before { issues.each { |issue| allow(issue).to receive(:runner).and_return(instance_runner) } }

      it 'returns count bundler audit issues' do
        expect(count).to eq(2)
      end
    end

    describe '#high' do
      subject(:high) { described_class.new(issues).high }

      let(:issues) { [bundler_issue, bundler_issue_one] }
      let(:bundler_issue) { instance_double(Inquisition::Issue, context: gem, severity: severity, runner: runner) }
      let(:bundler_issue_one) { instance_double(Inquisition::Issue, context: gem, severity: severity, runner: runner) }
      let(:runner) { instance_double(Inquisition::Bundler::Audit::Runner) }
      let(:gem) { instance_double(Bundler::LazySpecification, name: 'test') }
      let(:gem_link) { Inquisition::Outputter::Doc::GemDetails::DEFAULT_GEM_LINK }
      let(:gem_details) { instance_double(Inquisition::Outputter::Doc::GemDetails, name: gem.name, link: gem_link) }
      let(:severity) { instance_double(Inquisition::Severity, name: :high) }
      let(:instance_runner) { ::Inquisition::Bundler::Audit::Runner.new }

      before { issues.each { |issue| allow(issue).to receive(:runner).and_return(instance_runner) } }

      it 'returns bundler audit high issues' do
        expect(high).to eq(issues)
      end
    end
  end
end
