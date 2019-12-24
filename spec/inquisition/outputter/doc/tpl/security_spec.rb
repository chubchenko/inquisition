RSpec.describe Inquisition::Outputter::Doc::TPL::Security do
  describe '#produce' do
    subject(:layout) { described_class.new([]) }

    it { expect(layout.produce).to be_an_instance_of(Binding) }
  end

  describe '#brakeman' do
    subject(:security) { described_class.new([]) }

    let(:template) { instance_double(Inquisition::Outputter::Doc::Template) }

    before do
      allow(template).to receive(:render)
      allow(Inquisition::Outputter::Doc::Template).to receive(:new).and_return(template)

      security.brakeman
    end

    it do
      expect(template).to have_received(:render).with(
        instance_of(Inquisition::Outputter::Doc::TPL::Security::Brakeman)
      )
    end
  end

  describe '#patch_level' do
    subject(:security) { described_class.new([]) }

    let(:template) { instance_double(Inquisition::Outputter::Doc::Template) }

    before do
      allow(template).to receive(:render)
      allow(Inquisition::Outputter::Doc::Template).to receive(:new).and_return(template)

      security.patch_level
    end

    it do
      expect(template).to have_received(:render).with(
        instance_of(Inquisition::Outputter::Doc::TPL::Security::PatchLevel)
      )
    end
  end
end
