RSpec.describe Inquisition::Outputter::Doc::TPL::Security do
  include_examples 'produceable' do
    subject(:tpl) { described_class.new([]) }
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
