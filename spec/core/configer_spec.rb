# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::Configure, type: :unit do
  subject { Inquisition::Core::Configure.new(some: 'param') }

  describe '.new' do

    it 'set @args variable' do
      expect(subject.instance_variable_get(:@args)).to eq({ some: 'param' })
    end
  end

  describe '.call' do
    it 'call .setup method' do
      expect(subject).to receive(:setup)
      subject.call
    end
  end
end
