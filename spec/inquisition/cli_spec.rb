require './lib/inquisition/cli'

RSpec.describe Inquisition::CLI, type: :unit do
  subject { Inquisition::CLI.new }
  after { remove_base_config }

  before do
    stub_const('Inquisition::BaseConfig::TARGET_DIRECTORY', temp_folder)
  end

  describe '#install' do
    let(:output) { capture { subject.build } }

    context 'when config file is present' do
      before { create_base_config }

      it 'show information message' do
        expect(output).to have_output_message('Using existing config for inquisition...')
      end

      it { expect(File).to exist(base_config_file) }
    end

    context 'configuration file is not present' do
      before { output }

      it 'show information message' do
        expect(output).to have_output_message('Inquisition setuping...')
      end

      it { expect(File).to exist(base_config_file) }
    end
  end

  describe '#setup' do
    let(:output) { capture { subject.setup } }

    context 'when config file is present' do
      before { create_base_config }

      xit 'show information message' do
      end

      it { expect(File).to exist(base_config_file) }
    end

    context 'configuration file is not present' do
      it 'show information message' do
        expect{ subject.setup }.to raise_error(Inquisition::Error::BaseConfigAbsenseError,
                                               'Run inquisition build first')
      end
    end
  end
end
