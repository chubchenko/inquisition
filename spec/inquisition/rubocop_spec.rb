RSpec.describe Inquisition::Rubocop do
  describe '.configuration' do
    let(:config_store) { instance_double(RuboCop::ConfigStore) }

    before do
      allow(RuboCop::ConfigStore).to receive(:new).and_return(config_store)
      allow(config_store).to receive(:options_config=)
    end

    context 'when user configuration file is present' do
      before { allow(File).to receive(:exist?).and_return(true) }

      it do
        described_class.configuration
        expect(config_store).to have_received(:options_config=).with('.rubocop.yml')
      end
    end

    context 'when user configuration file is absent' do
      before { allow(File).to receive(:exist?).and_return(false) }

      it do
        described_class.configuration
        expect(config_store).to have_received(:options_config=).with(Inquisition.root + '/config/rubocop/config.yml')
      end
    end
  end
end
