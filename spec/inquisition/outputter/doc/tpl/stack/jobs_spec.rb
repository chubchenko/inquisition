RSpec.describe Inquisition::Outputter::Doc::TPL::Stack::Jobs do
  include_examples 'produceable' do
    subject(:tpl) { described_class.new }
  end

  describe '#collection' do
    subject(:collection) { described_class.new.collection }

    let(:collector) { instance_double(Inquisition::Outputter::Doc::TPL::Stack::Collector) }

    before do
      stub_const("#{described_class}::KNOWN", ['sidekiq'])
      allow(Inquisition::Outputter::Doc::TPL::Stack::Collector).to receive(:new)
        .with(described_class::KNOWN).and_return(collector)
      allow(collector).to receive(:call)
      collection
    end

    it 'returns Collector instance call' do
      expect(collector).to have_received(:call)
    end
  end
end
