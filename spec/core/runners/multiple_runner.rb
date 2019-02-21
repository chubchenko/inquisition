# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::Runners::MultipleRunner, type: :unit do
  subject { Inquisition::Core::Runners::MultipleRunner.new }

  describe '#call' do
    it 'call #run_installers' do
      expect(subject).to receive(:run_runners)
      subject.call
    end

    context 'base config is enabled' do
      let(:runner) { double('runner') }

      before do
        allow(subject).to receive(:runners) { [runner] }
        allow(Inquisition::BaseConfig).to receive(:config_enabled?) { true }
      end

      it 'call installer' do
        expect(runner).to receive_message_chain(:new, :call)
        subject.call
      end
    end

    context 'base config is disabled' do
      let(:runner) { double('runner') }

      before do
        allow(subject).to receive(:runners) { [runner] }
        allow(Inquisition::BaseConfig).to receive(:config_enabled?) { false }
      end

      it 'does not call installer' do
        expect(runner).not_to receive(:call)
        subject.call
      end
    end
  end
end
