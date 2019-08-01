RSpec.describe Inquisition::Runner do
  describe '.call' do
    it  do
      expect(described_class).to receive_message_chain(:new, :call)
      described_class.call
    end
  end

  describe '.define_name' do
    it 'return name runner' do
      allow(described_class).to receive(:name) { 'Inquisition::Brakeman::Runner' }
      expect(described_class.define_name).to eq('brakeman')
    end
  end

  describe '.enabled?' do
    it 'call method options' do
      expect(Inquisition::Configuration).to receive_message_chain(:instance, :options, :dig)
      described_class.enabled?
    end
  end
end
