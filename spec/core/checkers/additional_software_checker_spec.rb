# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::Checkers::AdditionalSoftwareChecker, type: :unit do
  subject { Inquisition::Core::Checkers::AdditionalSoftwareChecker.new(command: 'ruby -v') }

  describe '.call' do
    context 'when software not found' do
      before do
        allow(subject).to receive(:software_missing?) { true }
      end

      it 'raise AdditionalSoftwareAbsenceError' do
        expect{ subject.call }.to raise_error(Inquisition::Errors::AdditionalSoftwareAbsenceError)
      end
    end

    context 'when software presence' do
      it 'not to raise any error' do
        expect{ subject.call }.not_to raise_error
      end
    end
  end

  describe 'constants' do
    it 'exist NOT_FOUND_TEXT constant' do
      expect(subject.class.const_get(:NOT_FOUND_TEXT)).to eq('not found')
    end
  end
end
