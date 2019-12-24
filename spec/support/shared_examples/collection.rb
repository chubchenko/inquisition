RSpec.shared_examples 'collection' do
  describe '#collection' do
    subject(:collection) { described_class.new.collection }

    let(:collector) { instance_double(Inquisition::Outputter::Doc::TPL::Stack::Collector) }

    before do
      stub_const("#{described_class}::KNOWN", ['sidekiq'])
      stub_const("#{described_class}::DESCRIPTION", ['test'])
      allow(Inquisition::Outputter::Doc::TPL::Stack::Collector).to receive(:new)
        .with(described_class::KNOWN).and_return(collector)
      allow(collector).to receive(:call).with(description: described_class::DESCRIPTION)
      collection
    end

    it 'returns Collector instance call' do
      expect(collector).to have_received(:call).with(description: described_class::DESCRIPTION)
    end
  end
end
