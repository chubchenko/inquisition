RSpec.describe Inquisition::Outputter::HTML::Overview do
  describe '#produce' do
    subject(:overview) { described_class.new([]) }

    it { expect(overview.produce).to be_an_instance_of(Binding) }
  end

  describe '#by_category' do
    subject(:overview) { described_class.new([]) }

    let(:template) { instance_double(Inquisition::Outputter::HTML::Template) }

    before do
      allow(template).to receive(:render)
      allow(Inquisition::Outputter::HTML::Template).to receive(:new).and_return(template)

      overview.by_category
    end

    it do
      expect(template).to have_received(:render).with(
        instance_of(Inquisition::Outputter::HTML::Overview::ByCategory)
      )
    end
  end

  describe '#by_executor' do
    subject(:overview) { described_class.new([]) }

    let(:template) { instance_double(Inquisition::Outputter::HTML::Template) }

    before do
      allow(template).to receive(:render)
      allow(Inquisition::Outputter::HTML::Template).to receive(:new).and_return(template)

      overview.by_executor
    end

    it do
      expect(template).to have_received(:render).with(
        instance_of(Inquisition::Outputter::HTML::Overview::ByExecutor)
      )
    end
  end
end
