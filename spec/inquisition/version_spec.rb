RSpec.describe Inquisition::Version do
  before do
    allow(described_class).to receive(:major).and_return(0)
    allow(described_class).to receive(:minor).and_return(2)
    allow(described_class).to receive(:patch).and_return(3)
  end

  describe '.to_h' do
    it 'returns a hash representation' do
      expect(described_class.to_h).to eql(major: 0, minor: 2, patch: 3)
    end
  end

  describe '.to_a' do
    it 'returns an array representation' do
      expect(described_class.to_a).to eql([0, 2, 3])
    end
  end

  describe '.to_s' do
    it 'returns a string representation' do
      expect(described_class.to_s).to eql('0.2.3')
    end
  end
end
