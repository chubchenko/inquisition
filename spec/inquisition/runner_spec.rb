RSpec.describe Inquisition::Runner do
  describe '.badge' do
    it { expect(described_class.badge).to be_an_instance_of(Inquisition::Badge) }
  end
end
