# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Configer, type: :unit do

  describe '#call' do
    subject { Inquisition::Configer.call }

    context 'when authenticate configer' do
      before do
        allow(Inquisition::Installer).to receive(:config_exists?).and_return(true)
      end

      it_behaves_like 'call callable objects', Inquisition::Auditors::Backend::Configer => 'backend configer',
                                               Inquisition::Auditors::Frontend::Configer => 'frontend configer',
                                               Inquisition::Auditors::Common::Configer => 'common configer'
    end

    context 'when configer was not authenticate' do
      before do
        allow(Inquisition::Installer).to receive(:config_exists?).and_return(false)
      end

      it 'raise authenticate error' do
        expect{ subject.call }.to raise_error(Inquisition::Errors::BaseConfigAbsenseError)
      end
    end
  end
end
