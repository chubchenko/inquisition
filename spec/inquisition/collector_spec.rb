RSpec.describe Inquisition::Collector do
  describe '.invoke' do
    let(:collector) { instance_double(described_class) }
    let(:options) { instance_double(Inquisition::Options, options: {}) }
    let(:call) { 0 }

    before do
      allow(collector).to receive(:call).and_return(call)
      allow(described_class).to receive(:new).and_return(collector)
      allow(Inquisition::Options).to receive(:parse).and_return(options)
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
      let(:call) { 1 }

      before do
        allow(described_class).to receive(:exit)
        described_class.invoke
      end

      it { expect(described_class).to have_received(:exit) }
    end

    context 'when the options contain a executor callable' do
      let(:executor) { instance_double(Inquisition::Executor::Version) }

      before do
        allow(executor).to receive(:call).and_return(0)

        allow(options).to receive(:options).and_return(executor: executor)
      end

      it 'invokes the executor callable' do
        described_class.invoke

        expect(executor).to have_received(:call)
      end
    end
  end

  describe '#call' do
    context 'when there are no runners' do
      subject(:collector) { described_class.new(collection: []).call }

      it { is_expected.to be_zero }
    end

    context 'when there is at least 1 runner' do
      subject(:collector) { described_class.new(collection: [dummy]).call }

      let(:dummy) do
        Class.new(Inquisition::Runner) do
          def call
            ['a', %w[b c]]
          end

          def self.enabled?
            true
          end
        end
      end

      after { Inquisition::Runner.collection.delete(dummy) }

      it { is_expected.to eq(1) }
    end

    context 'when the runner is disabled' do
      subject(:collector) { described_class.new(collection: [dummy]).call }

      let(:dummy) do
        Class.new(Inquisition::Runner) do
          def call
            ['a', %w[b c]]
          end

          def self.enabled?
            false
          end
        end
      end

      after { Inquisition::Runner.collection.delete(dummy) }

      it { is_expected.to be_zero }
    end
  end
end
