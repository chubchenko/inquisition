RSpec.shared_examples 'produce' do |described_class|
  describe '#produce' do
    let(:produce) { described_class.produce }

    it { expect(produce).to be_an_instance_of(Binding) }
  end
end
