# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::Checkers::ExistFileChecker, type: :unit do
  subject { Inquisition::Core::Checkers::ExistFileChecker.new(**args) }
  let(:args) { { file: 'file.txt', destination: 'spec/fixtures' } }

  describe '.call' do
    context 'when file not found' do
      before do
        allow(subject).to receive(:file_exist?) { false }
      end

      it 'raise NoConfigFileError' do
        expect{ subject.call }.to raise_error(Inquisition::Error::NoConfigFileError)
      end
    end

    context 'when file presence' do
      it 'not to raise any error' do
        expect{ subject.call }.not_to raise_error
      end
    end
  end
end
