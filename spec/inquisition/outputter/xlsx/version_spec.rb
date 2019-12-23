RSpec.describe Inquisition::Outputter::Xlsx::Version do
  subject(:version) { described_class.new('1.0.0', '1.0.1') }

  describe '#current' do
    it { expect(version.current).to eq(Gem::Version.new('1.0.0')) }
  end

  describe '#latest' do
    it { expect(version.latest).to eq(Gem::Version.new('1.0.1')) }
  end

  describe '#outdated?' do
    it { is_expected.to be_outdated }
  end
end
