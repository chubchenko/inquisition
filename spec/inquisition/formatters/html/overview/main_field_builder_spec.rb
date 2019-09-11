RSpec.describe Inquisition::Formatters::HTML::Overview::MainFieldBuilder do
  subject(:builder) { described_class.new(collection) }

  let(:issue) do
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
