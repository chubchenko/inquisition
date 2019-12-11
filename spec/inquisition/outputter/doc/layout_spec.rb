RSpec.describe Inquisition::Outputter::Doc::Layout do
  describe '#produce' do
    subject(:layout) { described_class.new }

    it { expect(layout.produce).to be_an_instance_of(Binding) }
  end

  describe '#home' do
    subject(:layout) { described_class.new }

    let(:template) { instance_double(Inquisition::Outputter::Doc::Template) }

    before do
      allow(template).to receive(:render)
      allow(Inquisition::Outputter::Doc::Template).to receive(:new).and_return(template)

      layout.home
    end

    it do
      expect(template).to have_received(:render).with(
        instance_of(Inquisition::Outputter::Doc::Home)
      )
    end
  end
end
