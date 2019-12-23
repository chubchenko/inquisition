RSpec.describe Inquisition::Outputter::Doc::TPL::Layout do
  describe '#produce' do
    subject(:layout) { described_class.new(nil) }

    it { expect(layout.produce).to be_an_instance_of(Binding) }
  end

  describe 'methods that call templates' do
    subject(:layout) { described_class.new(nil) }

    let(:template) { instance_double(Inquisition::Outputter::Doc::Template) }

    before do
      allow(template).to receive(:render)
      allow(Inquisition::Outputter::Doc::Template).to receive(:new).and_return(template)
    end

    context 'when call #home template' do
      before { layout.home }

      it do
        expect(template).to have_received(:render).with(
          instance_of(Inquisition::Outputter::Doc::TPL::Home)
        )
      end
    end
  end
end
