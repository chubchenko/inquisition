RSpec.describe Inquisition::Severity do
  describe '.new' do
    context 'when the unknown severity is passed' do
      it do
        expect { described_class.new('unknown') }.to raise_error(ArgumentError, 'Unknown severity: unknown')
      end
    end
  end

  describe '#==' do
    subject { severity == other }

    let(:severity) { described_class.new(:high) }

    context 'when a name match' do
      let(:other) { described_class.new(:high) }

      it { is_expected.to be_truthy }
    end

    context 'when a name does not match' do
      let(:other) { described_class.new(:medium) }

      it { is_expected.to be_falsy }
    end
  end

  describe '#hash' do
    subject { severity.hash == other.hash }

    let(:severity) { described_class.new(:high) }

    context 'when a name match' do
      let(:other) { described_class.new(:high) }

      it { is_expected.to be_truthy }
    end

    context 'when a name does not match' do
      let(:other) { described_class.new(:medium) }

      it { is_expected.to be_falsy }
    end
  end
end
