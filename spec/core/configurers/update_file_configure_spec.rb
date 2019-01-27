# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::Configurers::UpdateFileConfigure do
  subject { Inquisition::Core::Configurers::UpdateFileConfigure.new(**args) }
  let(:args) { { file: 'config.txt', destination: 'spec/tmp' } }

  let(:spec_path) { File.join(Dir.pwd, 'spec') }
  let(:temp_path) { File.join(spec_path, 'tmp') }
  let(:file) { File.join(spec_path, 'tmp', args[:file]) }
  let(:config_file) { File.join(spec_path, 'fixtures', 'config.txt') }

  after do
    remove_file(file)
  end

  describe '.setup' do
    context 'when config file not exist' do

      it 'railse error' do
        expect{ subject.call }.to raise_error(Inquisition::Errors::NoConfigFileError)
      end
    end

    context 'when config file already exist' do
      before do
        copy_file(config_file, temp_path)
        allow(subject).to receive(:template_file) { config_file }
      end

      context 'when file already contains pasted data' do
        it 'contain pasted data' do
          subject.call
          expect(File.readlines(file).grep(/config/).any?).to be_truthy
        end
      end

      context 'when file not contains pasted data' do
        before do
          File.truncate(file, 0)
        end

        it 'contain pasted data' do
          subject.call
          expect(File.readlines(file).grep(/config/).any?).to be_truthy
        end
      end
    end
  end
end
