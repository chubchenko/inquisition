RSpec.describe Inquisition::Configuration do
  subject(:configuration) { Class.new(described_class).instance }

  describe '#to_h' do
    context 'when the file is missing' do
      before do
        allow(File).to receive(:exist?).with('.inquisition.yml').and_return(false)
      end

      it { expect(configuration.to_h).to eq({}) }
    end

    context 'when file is present' do
      before do
        allow(File).to receive(:exist?).with('.inquisition.yml').and_return(true)
        allow(YAML).to receive(:load_file).and_return(
          'plugins' => { 'reek' => { 'enabled' => true } }, 'verbose' => false
        )
      end

      it { expect(configuration.to_h).to eq('plugins' => { 'reek' => { 'enabled' => true } }, 'verbose' => false) }
    end
  end

  describe '#verbose?' do
    context 'when the file is missing' do
      before do
        allow(File).to receive(:exist?).with('.inquisition.yml').and_return(false)
      end

      it { is_expected.not_to be_verbose }
    end

    context 'when a value set to false' do
      before do
        allow(File).to receive(:exist?).with('.inquisition.yml').and_return(true)
        allow(YAML).to receive(:load_file).and_return('verbose' => false)
      end

      it { is_expected.not_to be_verbose }
    end

    context 'when a value set to true' do
      before do
        allow(File).to receive(:exist?).with('.inquisition.yml').and_return(true)
        allow(YAML).to receive(:load_file).and_return('verbose' => true)
      end

      it { is_expected.to be_verbose }
    end
  end
end
