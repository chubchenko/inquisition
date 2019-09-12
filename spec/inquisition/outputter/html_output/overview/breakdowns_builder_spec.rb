RSpec.describe Inquisition::Outputter::HtmlOutput::Overview::BreakdownsBuilder do
  subject(:builder) { described_class.new(collection) }

  let(:security_issue) do
    instance_double(
      Inquisition::Issue,
      path: '',
      line: '',
      severity: Inquisition::Severity::LOW,
      category: instance_double(Inquisition::Category, name: :security),
      message: '',
      runner: instance_double(Inquisition::Runner)
    )
  end

  let(:bug_risk_issue) do
    instance_double(
      Inquisition::Issue,
      path: '',
      line: '',
      severity: Inquisition::Severity::LOW,
      category: instance_double(Inquisition::Category, name: :bug_risk),
      message: '',
      runner: instance_double(Inquisition::Runner)
    )
  end

  let(:collection) { [security_issue, bug_risk_issue] }

  describe '#file_name' do
    it { expect(builder.file_name).to eq('breakdowns.html') }
  end

  describe '#categorized_issues' do
    it { expect(builder.categorized_issues.keys).to eq(%i[security bug_risk]) }
    it { expect(builder.categorized_issues[:security]).to eq([security_issue]) }
  end

  describe 'private method #percentage' do
    it { expect(builder.send(:percentage, [security_issue])).to eq(50) }
  end
end
