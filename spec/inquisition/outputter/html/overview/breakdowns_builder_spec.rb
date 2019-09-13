RSpec.describe Inquisition::Outputter::HTML::Overview::BreakdownsBuilder do
  subject(:builder) { described_class.new(collection) }

  let(:collection) { [security_issue, bug_risk_issue] }
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
  let(:script) do
    "<script type=\"text/javascript\">\n  var category_percentage = [50.0, 50.0, 0, 0, 0, 0, 0];\n</script>\n"
  end
  
  describe '#file_name' do
    it { expect(builder.file_name).to eq('breakdowns.html') }
  end

  describe '#js_chart' do
    it { expect(builder.js_chart).to eq(script) }
  end
end
