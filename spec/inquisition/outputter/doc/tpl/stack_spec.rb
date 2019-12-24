RSpec.describe Inquisition::Outputter::Doc::TPL::Stack do
  subject(:stack) { described_class.new }

  describe '#produce' do
    it { expect(stack.produce).to be_an_instance_of(Binding) }
  end

  describe '#ruby_version' do
    it
  end

  describe '#rails_version' do
    it
  end

  describe '#db' do
    it
  end

  describe '#jobs' do
    it
  end

  describe '#exception_and_instrumentation' do
    it
  end
end
