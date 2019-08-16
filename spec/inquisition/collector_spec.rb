RSpec.describe Inquisition::Collector do
  describe '.invoke' do
    let(:collector) { instance_double(Inquisition::Collector) }
    let(:call) { [] }

    before do
      allow(collector).to receive(:call).and_return(call)
      allow(Inquisition::Collector).to receive(:new).and_return(collector)
      allow(Inquisition::Options).to receive(:parse)
    end

    it do
      described_class.invoke

      expect(Inquisition::Options).to have_received(:parse).with(ARGV)
    end

    it do
      described_class.invoke

      expect(collector).to have_received(:call)
    end

    context 'when there are no issues' do
      before do
        allow(described_class).to receive(:exit)
        described_class.invoke
      end

      it { expect(described_class).not_to have_received(:exit) }
    end

    context 'when there is at least 1 issue' do
      let(:call) { ['a'] }

      before do
        allow(described_class).to receive(:exit)
        described_class.invoke
      end

      it { expect(described_class).to have_received(:exit) }
    end
  end

  describe '#call' do
    context 'when there are no runners' do
      subject(:collector) { described_class.new(collection: []).call }

      it { is_expected.to be_empty }
    end

    context 'when there is at least 1 runner' do
      subject(:collector) { described_class.new(collection: [dummy]).call }

      let(:dummy) do
        Class.new(Inquisition::Runner) do
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

      let(:dummy) do
        Class.new(Inquisition::Runner) do
          def call
            ['a', ['b', 'c']]
          end

          def self.enabled?
            false
          end
        end
      end

      it { is_expected.to be_empty }
    end
  end
end
