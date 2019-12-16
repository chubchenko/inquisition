RSpec.describe Inquisition::Outputter::Xlsx::Builder do
  describe '.call' do
    before do
      allow(builder).to receive(:call)
      allow(described_class).to receive(:new).and_return(builder)
      described_class.call([])
    end

    let(:builder) { instance_double(described_class) }
    it { expect(builder).to have_received(:call) }
  end

  describe '#call' do
    it
  end
end
