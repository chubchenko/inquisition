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

          def self.enabled?
            true
          end
        end
      end

      it { is_expected.to match_array(['a', 'b', 'c']) }
    end

    context 'when the runner is disabled' do
      subject(:collector) { described_class.new(collection: [dummy]).call }

      let(:runner) { Inquisition::Fasterer::Runner }
      let(:dummy) {
        Class.new do
          def self.enabled?
            false
          end
        end
      }

      it 'return call runner' do
        expect(runner).not_to receive(:new)
        collector
      end
    end
  end
end
