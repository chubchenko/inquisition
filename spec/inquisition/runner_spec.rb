RSpec.describe Inquisition::Runner do
  describe '.collection' do
  end

  describe '.config' do
    it 'call method to_h' do
      expect(Inquisition::Configuration).to receive_message_chain(:instance, :to_h)
      described_class.config
    end
  end
end
