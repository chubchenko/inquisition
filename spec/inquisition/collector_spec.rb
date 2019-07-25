RSpec.describe Inquisition::Collector do
  subject(:collector) { described_class.new }

  describe '.call' do
    context 'when create instance self' do
      it 'return new and method call' do
        expect(described_class).to receive_message_chain(:new, :call)
        described_class.call
      end
    end
  end

  describe '#call' do
    let(:collection) { [Inquisition::Brakeman::Runner] }
    let(:config) { { 'plugins' => { 'brakeman' => { 'enabled' => true } }, 'verbose' => false } }
    let(:configuration_instance) { Inquisition::Configuration.instance }

    context 'when call collection runners' do
      before do
        allow(Inquisition::Runner).to receive(:collection).and_return(collection)
        allow(configuration_instance).to receive(:to_h).and_return(config)
        allow(collection.first).to receive(:call).and_return([])
        allow(collector.call).to receive(:runner_enabled?).with(collection.first).and_return(true)
      end

      it 'return call without errors' do
        expect(collector.call).to eq([])
      end
    end
  end
end
