# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::Runners::SingleRunner, type: :unit do
  subject { Inquisition::Core::Runners::SingleRunner.new }

  before do
    allow(subject).to receive(:run_auditor) { true }
  end

  describe '.call' do
    let(:formatter) { double(:formatter) }

    before do
      allow(subject).to receive(:formatter) { formatter }
      allow(formatter).to receive_message_chain(:new, :call) { {} }
      subject.call
    end

    it 'set @spended_time' do
      expect(subject.instance_variable_get(:@spended_time)).to be_a(Float)
    end

    it 'set @formatted_output' do
      expect(subject.instance_variable_get(:@formatted_output)).to be_a(Hash)
    end
  end
end
