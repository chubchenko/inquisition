RSpec.describe Inquisition::Outputter::Doc::TPL::Stack do
  subject(:stack) { described_class.new }

  describe '#produce' do
    it { expect(stack.produce).to be_an_instance_of(Binding) }
  end
end
