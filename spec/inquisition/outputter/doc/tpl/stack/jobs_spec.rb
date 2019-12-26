RSpec.describe Inquisition::Outputter::Doc::TPL::Stack::Jobs do
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
      allow(collector).to receive(:call).and_return([])

      exception.collection
    end

    it do
      expect(Inquisition::Outputter::Doc::TPL::Stack::Collector).to have_received(:new).with(described_class::KNOWN)
    end

    it { expect(collector).to have_received(:call) }
  end
end
