RSpec.describe Inquisition do
  describe '.logger' do
    let(:configuration) { instance_double(Inquisition::Configuration) }

    before { allow(Inquisition::Configuration).to receive(:instance) { configuration } }

    context 'when the verbose mode is on' do
      before do
        allow(configuration).to receive(:verbose?).and_return(true)

        allow(Inquisition::Logger).to receive(:new)
      end

      it do
        described_class.logger

        expect(Inquisition::Logger).to have_received(:new).with(STDOUT, level: Logger::INFO)
      end
    end

    context 'when the verbose mode is off' do
      before do
        allow(configuration).to receive(:verbose?).and_return(false)

        allow(Inquisition::Logger).to receive(:new)
      end

      it do
        described_class.logger

        expect(Inquisition::Logger).to have_received(:new).with(instance_of(File))
      end
    end
  end

  describe '.root' do
    it 'returns the full path to the gem directory' do
      expect(described_class.root).to eq(
        Gem::Specification.find_by_name('inquisition').gem_dir
      )
    end
  end

  describe '.configuration' do
    it { expect(described_class.configuration).to eq(Inquisition::Configuration.instance) }
  end
end
