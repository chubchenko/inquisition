RSpec.describe Inquisition::Configuration do
  # let(:config_file) { Inquisition::Configuration::CONFIG_FILE_NAME }
  # let(:user_configure_file) { { 'plugins' => [], 'verbose' => true } }
  # let(:default_hash) { Inquisition::Configuration::DEFAULT_HASH }
  # subject { Inquisition::Configuration.instance }
  #
  # describe '#to_h' do
  #   context 'when config file exists' do
  #     before do
  #       File.open("./spec/fixtures/#{config_file}", 'w') { |f| f.write user_configure_file.to_yaml }
  #     end
  #
  #     it 'file exist' do
  #       allow(subject).to receive(:config_exist?).and_return(true)
  #       allow(subject).to receive(:data_config).and_return(user_configure_file)
  #       expect(subject.to_h).to eq(user_configure_file)
  #     end
  #
  #     after { File.delete("./spec/fixtures/#{config_file}") }
  #   end
  #
  #   context 'when config file not exists' do
  #     it 'file not exist' do
  #       expect(subject.to_h).to eq(default_hash)
  #     end
  #   end
  # end
  #
  # describe '#verbose?' do
  #   context 'check verbose true or false' do
  #     it 'return false' do
  #       allow(subject).to receive(:to_h).and_return(default_hash)
  #       expect(subject.verbose?).to eq(false)
  #     end
  #
  #     it 'return true' do
  #       allow(subject).to receive(:to_h).and_return(user_configure_file)
  #       expect(subject.verbose?).to eq(true)
  #     end
  #   end
  # end

  # TODO: what about singleton

  subject(:configuration) { described_class.instance }

  # describe '#to_h' do
  #   context 'when the file is absent' do
  #     it { is_expected.to be_empty }
  #   end
  #
  #   context 'when the file is present' do
  #     it { is_expected.to include(verbose: false, pg: []) }
  #   end
  # end

  describe '#verbose?' do
    # context 'when the file is absent' do
    #   it { is_expected.not_to be_verbose }
    # end
    #
    # context 'when the option is absent' do
    #   it { is_expected.not_to be_verbose }
    # end
    #
    # context 'when the option is eq f' do
    #   it { is_expected.not_to be_verbose }
    # end
    #
    # context 'when the option is eq t' do
    #   it { is_expected.to be_verbose }
    # end
  end
end
