# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::Checkers::GemChecker, type: :unit do
  subject { Inquisition::Core::Checkers::GemChecker.new(**args) }
  let(:args) { { name: 'rspec' } }

  describe '.call' do
    context 'when gem not found' do
      let(:args) { { name: 'some-unknown-gem' } }

      it 'raise NoGemError' do
        expect{ subject.call }.to raise_error(Inquisition::Errors::NoGemError)
      end
    end

    context 'when gem presence' do
      it 'not to raise any error' do
        expect{ subject.call }.not_to raise_error
      end
    end
  end
end
