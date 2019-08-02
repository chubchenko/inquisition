RSpec.describe Inquisition::Badge do
  describe '.for' do
    before do
      allow(described_class).to receive(:new)
      described_class.for('Inquisition::Dr::GlipGlop::Runner')
    end

    it { expect(described_class).to have_received(:new).with('dr_glip_glop') }
  end

  describe '#to_s' do
    subject(:badge) { described_class.new('rubocop') }

    it { expect(badge.to_s).to eq('rubocop') }
  end
end
