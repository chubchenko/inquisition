RSpec.describe Inquisition::Collector do
  describe '#call' do
    context 'when there are no runners' do
      subject(:collector) { described_class.new(collection: []).call }

      it { is_expected.to be_empty }
    end

    context 'when there is at least 1 runner' do
      subject(:collector) { described_class.new(collection: [dummy]).call }

      let(:dummy) do
        Class.new do
          def call
            ['a', ['b', 'c']]
          end
        end
      end

      it { is_expected.to match_array(['a', 'b', 'c']) }
    end
  end
end
