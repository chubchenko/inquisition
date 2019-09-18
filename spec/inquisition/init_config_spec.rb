RSpec.describe Inquisition::InitConfig do
  let(:config_file) { File.join(Rails.root, '.inquisition.yml') }
  let(:runners) do
    Inquisition::Runner.descendants.select { |runner| runner.to_s.include?('Runner') }
  end

  before { allow(described_class).to receive(:runners).and_return(runners) }

  describe '.runners' do
    it 'returns all available runners' do
      described_class.runners.each do |runner|
        expect(Inquisition.constants).to include(runner.to_s.split('::')[1].to_sym)
      end
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
