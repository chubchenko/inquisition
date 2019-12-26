RSpec.describe Inquisition::Outputter do
  describe '.declare' do
    it 'changes outputter count by 1' do
      expect do
        described_class.declare(:doc, :example_passed)
      end.to change(Inquisition::Outputter::Loader.collection, :count).by(1)
    end
  end
end

RSpec.describe Inquisition::Outputter::Loader do
  subject(:loader) { described_class.new(fanout: fanout) }

  let(:fanout) { instance_double(Inquisition::Fanout) }

  describe '.collection' do
    before { Inquisition::Outputter.declare(:json, :example_passed) }

    it 'returns collection of outputters' do
      expect(described_class.collection).to include(
        json: [
          :example_passed
        ]
      )
    end
  end

  describe '#add' do
    before { allow(fanout).to receive(:register_listener) }

    it 'pushes a outputter by the name' do
      expect do
        loader.add('progress')
      end.to change(loader, :collection).to(match_array(Inquisition::Outputter::Progress))
    end

    it 'raises ArgumentError if outputter is unknown' do
      expect do
        loader.add('nonexistent')
      end.to raise_error(ArgumentError, 'Outputter nonexistent unknown')
    end
  end

  describe '#remove' do
    before do
      allow(fanout).to receive(:register_listener)
      allow(fanout).to receive(:unregister_listener)
    end

    it 'removes a outputter by the name' do
      outputter = Inquisition::Outputter::Progress.new
      loader.add(outputter)

      expect do
        loader.remove(outputter)
      end.to change(loader.collection, :count).by(-1)
    end

    it 'raises ArgumentError if outputter is unknown' do
      outputter = Class.new

      expect do
        loader.remove(outputter)
      end.to raise_error(ArgumentError, "Outputter #{outputter} unknown")
    end
  end

  describe '#prepare_default' do
    before { allow(fanout).to receive(:prepare_default) }

    it do
      loader.prepare_default

      expect(fanout).to have_received(:prepare_default).with(loader)
    end
  end

  describe '#setup_default' do
    before { allow(fanout).to receive(:register_listener) }

    context 'when there is no loaded outputter' do
      it do
        expect do
          loader.setup_default
        end.to change(loader.collection, :count).by(1)
      end

      it do
        loader.setup_default

        expect(fanout).to have_received(:register_listener).with(
          Inquisition::Outputter::Progress,
          :example_passed, :example_failed, :stop
        )
      end
    end

    context 'when there is loaded outputter' do
      before { loader.add('doc') }

      it do
        expect do
          loader.setup_default
        end.not_to change(loader.collection, :count)
      end
    end
  end
end
