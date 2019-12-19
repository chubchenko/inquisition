RSpec.describe Inquisition::Outputter::Doc::Filters::BundlerAudit::Collection do
  describe '#group' do
    subject(:group) { described_class.new(issues).group }

    let(:issues) { [bundler_issue, bundler_issue_first] }
    let(:bundler_issue) { instance_double(Inquisition::Issue, context: gem,
                                          runner: runner, severity: severity) }
    let(:bundler_issue_first) { instance_double(Inquisition::Issue, context: gem, runner: runner) }
    let(:runner) { instance_double(Inquisition::Bundler::Audit::Runner) }
    let(:gem) { instance_double(Bundler::LazySpecification, name: 'test') }
    let(:severity) { instance_double(Inquisition::Severity, name: :high) }
    let(:gem_link) { Inquisition::Outputter::Doc::GemDetails::DEFAULT_GEM_LINK }
    let(:gem_details) { instance_double(Inquisition::Outputter::Doc::GemDetails, name: gem.name, link: gem_link) }

    before do
      issues.each { |issue| allow(issue).to receive(:runner).and_return(::Inquisition::Bundler::Audit::Runner) }
    end

    it 'returns grouped bundler audit by gem name' do
      expect(group).to eq({ name: gem.name, link: gem_link } => [bundler_issue, bundler_issue_first])
    end
  end

  describe '#count' do
    subject(:count) { described_class.new(issues).count }

    let(:issues) { [bundler_issue, bundler_issue_first] }
    let(:bundler_issue) { instance_double(Inquisition::Issue, context: gem, runner: runner) }
    let(:bundler_issue_first) { instance_double(Inquisition::Issue, context: gem, runner: runner) }
    let(:runner) { instance_double(Inquisition::Bundler::Audit::Runner) }
    let(:gem) { instance_double(Bundler::LazySpecification, name: 'test') }
    let(:gem_link) { Inquisition::Outputter::Doc::GemDetails::DEFAULT_GEM_LINK }
    let(:gem_details) { instance_double(Inquisition::Outputter::Doc::GemDetails, name: gem.name, link: gem_link) }

    before do
      issues.each { |issue| allow(issue).to receive(:runner).and_return(::Inquisition::Bundler::Audit::Runner) }
    end

    it 'returns count bundler audit issues' do
      expect(count).to eq(2)
    end
  end

  describe '#high' do
    subject(:high) { described_class.new(issues).high }

    let(:issues) { [bundler_issue, bundler_issue_first] }
    let(:bundler_issue) { instance_double(Inquisition::Issue, context: gem, severity: severity, runner: runner) }
    let(:bundler_issue_first) { instance_double(Inquisition::Issue, context: gem, severity: severity, runner: runner) }
    let(:runner) { instance_double(Inquisition::Bundler::Audit::Runner) }
    let(:gem) { instance_double(Bundler::LazySpecification, name: 'test') }
    let(:gem_link) { Inquisition::Outputter::Doc::GemDetails::DEFAULT_GEM_LINK }
    let(:gem_details) { instance_double(Inquisition::Outputter::Doc::GemDetails, name: gem.name, link: gem_link) }
    let(:severity) { instance_double(Inquisition::Severity, name: :high) }

    before do
      issues.each { |issue| allow(issue).to receive(:runner).and_return(::Inquisition::Bundler::Audit::Runner) }
    end

    it 'returns bundler audit high issues' do
      expect(high).to eq(issues)
    end
  end

end
