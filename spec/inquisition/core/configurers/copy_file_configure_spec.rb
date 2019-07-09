require 'spec_helper'

RSpec.describe Inquisition::Core::Configurers::CopyFileConfigure, type: :unit do
  subject { Inquisition::Core::Configurers::CopyFileConfigure.new(**args) }
  let(:args) { { file: 'file.txt', destination: 'spec/inquisition/tmp' } }
  let(:spec_path) { File.join(Dir.pwd, 'spec', 'inquisition') }
  let(:temp_path) { File.join(spec_path, 'tmp') }
  let(:file) { File.join(spec_path, 'tmp', args[:file]) }

  after do
    remove_file(file)
  end

  describe '.setup' do
    context 'when file not exist' do
      before do
        allow(subject).to receive(:config_file_exist?) { false }
        allow(subject).to receive(:config_path) { File.join(spec_path, 'fixtures', args[:file]) }
      end

      it 'copy file' do
        subject.call
        expect(File.file?(file)).to be_truthy
      end
    end

    context 'when file already exist' do
      before do
        copy_file(File.join(spec_path, 'fixtures', args[:file]), temp_path)
        allow(subject).to receive(:destination) { temp_path }
      end

      it 'exist file' do
        subject.call
        expect(File.file?(file)).to be_truthy
      end
    end
  end
end
