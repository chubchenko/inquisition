RSpec.describe Inquisition::Fasterer::Config do
  describe '#nil_file' do
    subject(:run_method) { described_class.new.nil_file }

    let(:load_config) do
      { 'speedups' => {}, 'exclude_paths' => {} }
    end

    it 'check upper class' do
      expect(described_class).to be < ::Fasterer::Config
    end

    context 'when call method' do
      before { allow(YAML).to receive(:load_file).and_return(load_config) }

      it 'return hash' do
        expect(run_method).to eq(load_config)
      end
    end
  end

  describe '#load_config' do
    subject(:run_method) { described_class.new.load_config }

    it 'check upper class' do
      expect(described_class).to be < ::Fasterer::Config
    end

    it 'call load_file ' do
      allow(YAML).to receive(:load_file)
      run_method
      expect(YAML).to have_received(:load_file)
    end
  end
end
