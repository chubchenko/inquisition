# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::Installers::MultipleInstaller, type: :unit do
  subject { Inquisition::Core::Installers::MultipleInstaller }

  describe '#call' do
    it 'call #run_installers' do
      expect(subject).to receive(:run_installers)
      subject.call
    end

    context 'base config is enabled' do
      let(:installer) { double('installer') }

      before do
        allow(subject).to receive(:installers) { [installer] }
        allow(Inquisition::BaseConfig).to receive(:config_enabled?) { true }
      end

      it 'call installer' do
        expect(installer).to receive(:call)
        subject.call
      end
    end

    context 'base config is disabled' do
      let(:installer) { double('installer') }

      before do
        allow(subject).to receive(:installers) { [installer] }
        allow(Inquisition::BaseConfig).to receive(:config_enabled?) { false }
      end

      it 'does not call installer' do
        expect(installer).not_to receive(:call)
        subject.call
      end
    end
  end
end
