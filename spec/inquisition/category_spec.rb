RSpec.describe Inquisition::Category do
  describe '.new' do
    context 'when the unknown category is passed' do
      it do
        expect { described_class.new('unknown') }.to raise_error(ArgumentError, 'Unknown category: unknown')
      end
    end
  end

  describe '#==' do
    subject { category == other }

    let(:category) { described_class.new(:security) }

    context 'when a name match' do
      let(:other) { described_class.new(:security) }

      it { is_expected.to be_truthy }
    end

    context 'when a name does not match' do
      let(:other) { described_class.new(:style) }

      it { is_expected.to be_falsy }
    end
  end

  describe '#hash' do
    subject { category.hash == other.hash }

    let(:category) { described_class.new(:security) }

    context 'when a name match' do
      let(:other) { described_class.new(:security) }

      it { is_expected.to be_truthy }
    end

    context 'when a name does not match' do
      let(:other) { described_class.new(:style) }

      it { is_expected.to be_falsy }
    end
  end
end
