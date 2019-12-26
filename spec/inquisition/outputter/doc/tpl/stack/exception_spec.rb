RSpec.describe Inquisition::Outputter::Doc::TPL::Stack::Exception do
  include_examples 'produceable' do
    subject(:tpl) { described_class.new }
  end

  describe '#collection' do
    subject(:exception) { described_class.new }

    let(:collector) { instance_double(Inquisition::Outputter::Doc::TPL::Stack::Collector) }

    before do
      allow(Inquisition::Outputter::Doc::TPL::Stack::Collector).to receive(:new).with(
        described_class::KNOWN
      ).and_return(collector)
      allow(collector).to receive(:call).with(description: described_class::DESCRIPTION).and_return([])

      exception.collection
    end

    it do
      expect(Inquisition::Outputter::Doc::TPL::Stack::Collector).to have_received(:new).with(described_class::KNOWN)
    end

    it { expect(collector).to have_received(:call).with(description: described_class::DESCRIPTION) }
  end

  describe '#empty?' do
    subject(:exception) { described_class.new }

    let(:collector) { instance_double(Inquisition::Outputter::Doc::TPL::Stack::Collector) }

    before do
      allow(Inquisition::Outputter::Doc::TPL::Stack::Collector).to receive(:new).with(
        described_class::KNOWN
      ).and_return(collector)
      allow(collector).to receive(:call).with(description: described_class::DESCRIPTION).and_return(collection)
    end

    context 'when there is at least one used gem' do
      let(:collection) do
        [OpenStruct.new(name: 'puma', homepage: 'http://puma.io', description: described_class::DESCRIPTION)]
      end

      it { is_expected.not_to be_empty }
    end

    context 'when there are no used gems' do
      let(:collection) { [] }

      it { is_expected.to be_empty }
    end
  end

  describe '#trouble' do
    subject(:exception) { described_class.new }

    it { expect(exception.trouble).to be_an_instance_of(Inquisition::Outputter::Doc::TPL::Stack::NoExceptionPkg) }
  end
end
