RSpec.describe Inquisition::Fanout do
  subject(:fanout) { described_class.new }

  let(:outputter) do
    Class.new do
      def start(_payload); end

      def example_passed(_payload); end

      def example_failed(_payload); end

      def stop(_payload); end
    end.new
  end

  describe '#register_listener' do
    before { fanout.register_listener(outputter, :example_passed) }

    it { expect(fanout.listeners_for(:example_passed)).to match_array(outputter) }

    it 'will send notice when a subscribed event is triggered' do
      allow(outputter).to receive(:example_passed)

      fanout.example_passed(Inquisition::NullPayload.new)

      expect(outputter).to have_received(:example_passed).with(instance_of(Inquisition::NullPayload))
    end
  end

  describe '#around' do
    before { fanout.register_listener(outputter, :start, :stop) }

    it 'yields itself' do
      yielded = nil

      fanout.around { |f| yielded = f }

      expect(yielded).to eq(fanout)
    end

    it 'will send notice when a start event is triggered' do
      allow(outputter).to receive(:start)

      fanout.around

      expect(outputter).to have_received(:start).with(instance_of(Inquisition::NullPayload))
    end

    it 'will send notice when a stop event is triggered' do
      allow(outputter).to receive(:stop)

      fanout.around

      expect(outputter).to have_received(:stop).with(instance_of(Array))
    end

    it { expect(fanout.around {}).to be_empty }
    it { expect(fanout.around { [1, 2, 3] }).to contain_exactly(1, 2, 3) }
  end

  describe '#example_passed' do
    before { fanout.register_listener(outputter, :example_passed) }

    it 'will send notice when a example passed event is triggered' do
      allow(outputter).to receive(:example_passed)

      fanout.example_passed(Inquisition::NullPayload.new)

      expect(outputter).to have_received(:example_passed).with(instance_of(Inquisition::NullPayload))
    end
  end

  describe '#example_failed' do
    before { fanout.register_listener(outputter, :example_failed) }

    it 'will send notice when a example failed event is triggered' do
      allow(outputter).to receive(:example_failed)

      fanout.example_failed(Inquisition::NullPayload.new)

      expect(outputter).to have_received(:example_failed).with(instance_of(Inquisition::NullPayload))
    end
  end
end
