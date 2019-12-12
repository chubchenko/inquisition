RSpec.describe Inquisition::Outputter::Doc::Template do
  describe '#render' do
    subject(:template) { described_class.new('layout') }

    let(:erb) { instance_double(ERB) }
    let(:binding) { instance_double(Binding) }
    let(:layout) { instance_double(Inquisition::Outputter::Doc::Layout) }

    before do
      allow(layout).to receive(:produce).and_return(binding)
      allow(erb).to receive(:result).and_return('')
      allow(ERB).to receive(:new).and_return(erb)
    end

    it 'produces template' do
      template.render(layout)

      expect(erb).to have_received(:result).with(binding)
    end
  end
end
