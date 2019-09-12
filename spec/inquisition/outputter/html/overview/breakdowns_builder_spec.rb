RSpec.describe Inquisition::Outputter::HTML::Overview::BreakdownsBuilder do
  subject(:builder) { described_class.new(collection) }

  let(:security_issue) do
    instance_double(
      Inquisition::Issue,
      path: 'app/controllers/application_controller.rb',
      line: 5,
      severity: Inquisition::Severity::LOW,
      category: instance_double(Inquisition::Category, name: :security),
      message: "ApplicationController#test_fasterer doesn't depend on instance state (maybe move it to another class?)",
      runner: instance_double(Inquisition::Runner)
    )
  end

  let(:bug_risk_issue) do
    instance_double(
      Inquisition::Issue,
      path: 'db/migrate/20190801142754_create_active_storage_tables.active_storage.rb',
      line: 9,
      severity: Inquisition::Severity::LOW,
      category: instance_double(Inquisition::Category, name: :bug_risk),
      message: "CreateActiveStorageTables#change refers to 'table' more than self (maybe move it to another class?)",
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
