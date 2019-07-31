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

    context 'call enabled runner' do
      subject(:collector) { described_class.new(collection: collection).call }

      let(:first_runner) { Inquisition::Brakeman::Runner }
      let(:second_runner) { Inquisition::Fasterer::Runner }
      let(:collection) { [first_runner, second_runner] }
      let(:config) do
        {
          'plugins' => {
            'brakeman' => { 'enabled' => true },
            'fasterer' => { 'enabled' => false }
          }
        }
        end

      it 'return call runner' do
        allow(first_runner).to receive(:config) { config }
        allow(second_runner).to receive(:config) { config }

        expect(first_runner).to receive_message_chain(:new, :call)
        expect(second_runner).not_to receive(:new)
        collector
      end
    end
  end
end
