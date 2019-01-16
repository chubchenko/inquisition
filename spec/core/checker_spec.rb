# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::Checker, type: :unit do
  subject { Inquisition::Core::Checker.new(some: 'param') }

  describe '.new' do

    it 'set @args variable' do
      expect(subject.instance_variable_get(:@args)).to eq({ some: 'param' })
    end
  end

  describe '.call' do
    it 'call .check method' do
      expect(subject).to receive(:check)
      subject.call
    end
  end
end
