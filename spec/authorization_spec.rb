# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Authorization do
  subject { Class.new { extend Inquisition::Authorization } }

  describe '#authenticate_installer' do
    context 'when config file is present' do
      before do
        allow(Inquisition::BaseConfig.instance).to receive(:config_exist?).and_return(true)
      end

      it 'not raise error' do
        expect{ subject.authenticate_installer }.not_to raise_error
      end
    end

    context 'configuration file is not present' do
      before do
        allow(Inquisition::BaseConfig).to receive(:config_exist?).and_return(false)
      end

      it 'raise error' do
        expect{ subject.authenticate_installer }.to raise_error(Inquisition::Errors::BaseConfigAbsenseError)
      end
    end
  end
end
