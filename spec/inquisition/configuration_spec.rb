require 'yaml'

RSpec.describe Inquisition::Configuration do
  subject(:configuration) { described_class.instance }

  let(:config_file) { Inquisition::Configuration::CONFIG_FILE_NAME }
  let(:user_configure_file) { { 'plugins' => [], 'verbose' => true } }
  let(:default_hash) { { 'plugins' => { 'brakeman' => { 'enabled' => true } }, 'verbose' => false } }

  describe '#to_h' do
    context 'when config file exists' do
      before do
        File.open("./spec/fixtures/#{config_file}", 'w') { |f| f.write user_configure_file.to_yaml }
      end

      after { File.delete("./spec/fixtures/#{config_file}") }

      it 'file exist' do
        allow(configuration).to receive(:config_exist?).and_return(true)
        allow(configuration).to receive(:data_config).and_return(user_configure_file)
        expect(configuration.to_h).to eq(user_configure_file)
      end
    end

    context 'when config file not exists' do
      it 'file not exist' do
        expect(configuration.to_h).to eq(default_hash)
      end
    end
  end

  describe '#verbose?' do
    context 'when check verbose true or false' do
      it 'return false' do
        allow(configuration).to receive(:to_h).and_return(default_hash)
        expect(configuration.verbose?).to eq(false)
      end

      it 'return true' do
        allow(configuration).to receive(:to_h).and_return(user_configure_file)
        expect(configuration.verbose?).to eq(true)
      end
    end
  end
end
