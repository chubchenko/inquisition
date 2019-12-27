RSpec.shared_examples 'produceable' do
  describe '#produce' do
    it { expect(tpl.produce).to be_an_instance_of(Binding) }
  end
end
