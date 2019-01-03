# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Configer, type: :unit do

  describe '#call' do
    subject { Inquisition::Configer.call }

    context 'when authenticate configer' do
      before do
        allow(Inquisition::BaseConfig).to receive(:config_exist?).and_return(true)
        allow(Inquisition::BaseConfig).to receive(:config_enabled?).and_return(false)
      end

      context 'when backend configers are enabled' do
        before do
          allow(Inquisition::BaseConfig).to receive(:config_enabled?).with(:linters, :backend).and_return(true)
        end

        it_behaves_like 'call callable objects', Inquisition::Auditors::Backend::Configer => 'backend configer'
      end

      context 'when frontend configers are enabled' do
        before do
          allow(Inquisition::BaseConfig).to receive(:config_enabled?).with(:linters, :frontend).and_return(true)
        end

        it_behaves_like 'call callable objects', Inquisition::Auditors::Frontend::Configer => 'frontend configer'
      end

      context 'when common configers are enabled' do
        before do
          allow(Inquisition::BaseConfig).to receive(:config_enabled?).with(:linters, :common).and_return(true)
        end

        it_behaves_like 'call callable objects', Inquisition::Auditors::Common::Configer => 'common configer'
      end
    end

    context 'when configer was not authenticate' do
      before do
        allow(Inquisition::BaseConfig).to receive(:config_exist?).and_return(false)
      end

      it 'raise authenticate error' do
        expect{ subject.call }.to raise_error(Inquisition::Errors::BaseConfigAbsenseError)
      end
    end
  end
end
