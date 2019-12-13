RSpec.describe Inquisition::Outputter::Doc::Templates::PatchLevelVerification do
  describe '#group_bundler_audit_issues' do
    subject(:group_bundler_audit_issues) { described_class.new(issues).group_bundler_audit_issues }

    let(:issues) { [bundler_issue, bundler_issue_first] }
    let(:bundler_issue) { instance_double(Inquisition::Issue, aditional_data: scanner, runner: runner) }
    let(:bundler_issue_first) { instance_double(Inquisition::Issue, aditional_data: scanner, runner: runner) }
    let(:runner) { instance_double(Inquisition::Bundler::Audit::Runner) }
    let(:scanner) { instance_double(Bundler::Audit::Scanner::UnpatchedGem, gem: gem) }
    let(:gem) { instance_double(Bundler::LazySpecification, name: 'test') }
    let(:badge) { instance_double('Inquisition::Badge', name: 'bundler_audit') }
    let(:gem_details) { instance_double(Inquisition::Outputter::Doc::GemDetails, name: gem.name, link: 'test_link') }

    before do
      allow(Inquisition::Badge).to receive(:for).and_return(badge)
      allow(Inquisition::Outputter::Doc::GemDetails).to receive(:new).and_return(gem_details)
    end

    it 'returns grouped bundler audit by gem name' do
      expect(group_bundler_audit_issues).to eq({ name: gem_details.name,
                                                 link: gem_details.link } => [bundler_issue, bundler_issue_first])
    end
  end
end
