RSpec.describe Inquisition::Outputter::HTML::Overview::MainFieldBuilder do
  subject(:builder) { described_class.new(collection) }

  let(:issue) do
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
  let(:collection) { [issue, issue] }

  describe '#file_name' do
    it { expect(builder.file_name).to eq('main_field.html') }
  end

  describe '#sorted_issues' do
    it { expect(builder.sorted_issues).to eq(collection.group_by(&:runner)) }
  end

  describe '#percentage' do
    it { expect(builder.percentage([issue])).to eq(50) }
  end
end
