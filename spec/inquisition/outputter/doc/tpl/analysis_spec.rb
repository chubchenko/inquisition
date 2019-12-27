RSpec.describe Inquisition::Outputter::Doc::TPL::Analysis do
  include_examples 'produceable' do
    subject(:tpl) { described_class.new([]) }
  end

  describe '#rubycritic' do
    subject(:security) { described_class.new([]) }

    let(:template) { instance_double(Inquisition::Outputter::Doc::Template) }

    before do
      allow(template).to receive(:render)
      allow(Inquisition::Outputter::Doc::Template).to receive(:new).and_return(template)

      security.rubycritic
    end

    it do
      expect(template).to have_received(:render).with(
        instance_of(Inquisition::Outputter::Doc::TPL::Analysis::Rubycritic)
      )
    end
  end
end
