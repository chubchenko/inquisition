RSpec.describe Inquisition::InitConfig do
  let(:config_file) { File.join(Rails.root, '.inquisition.yml') }

  describe '.runners' do
    let(:runners) { Inquisition::Runner.descendants.map { |runner| runner.badge.to_s } }

    it 'returns all available runners' do
      expect(described_class.runners).to eql(runners)
    end
  end

  describe '.create_config' do
    after { FileUtils.rm_r(config_file) }

    it 'creates config file' do
      described_class.create_config
      expect(File).to exist(config_file)
    end
  end

  describe '.result' do
    context 'when file was created' do
      after { FileUtils.rm_r(config_file) }

      before { allow(File).to receive(:exist?).and_return(true) }

      it { expect(described_class.result).to eql('Config file was created successfully') }
    end

    context 'when file was not created' do
      after { FileUtils.rm_r(config_file) }

      before { allow(File).to receive(:exist?).and_return(false) }

      it { expect(described_class.result).to eql('Something went wrong') }
    end
  end
end
