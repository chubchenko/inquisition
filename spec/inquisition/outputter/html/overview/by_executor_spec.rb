RSpec.describe Inquisition::Outputter::HTML::Overview::ByExecutor do
  describe '#to_percentage' do
    subject(:by_executor) { described_class.new([issue, issue]) }

    let(:issue) do
      Inquisition::Issue.new(
        path: 'app/controllers/users_controller.rb',
        line: 42,
        severity: Inquisition::Severity::HIGH,
        message: 'Potentially dangerous key allowed for mass assignment',
        category: Inquisition::Category::SECURITY,
        runner: Inquisition::Brakeman::Runner.new,
        warning_type: nil
      )
    end

    it 'returns percentage' do
      expect(by_executor.to_percentage([issue])).to eq(50)
    end
  end

  describe '#produce' do
    subject(:by_executor) { described_class.new([]) }

    it { expect(by_executor.produce).to be_an_instance_of(Binding) }
  end
end
