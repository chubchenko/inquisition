RSpec.describe Inquisition::Outputter::HTML::Issues do
  describe '#produce' do
    subject(:issues) { described_class.new([]) }

    it { expect(issues.produce).to be_an_instance_of(Binding) }
  end
end
