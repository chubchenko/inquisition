# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::CLI do
  subject { Inquisition::CLI.new }
  after { remove_base_config }

  describe '#install' do
    let(:output) { capture { subject.install } }

    context 'when config file is present' do
      before { create_base_config }

      it 'show information message' do
        expect(output).to have_output_message(I18n.t('messages.using_existing_config'))
      end

      it_behaves_like 'present file', CLIHelpModule::BASE_CONFIG_FILE_NAME => 'base config'
    end

    context 'configuration file is not present' do
      before { output }

      it 'show information message' do
        expect(output).to have_output_message(I18n.t('messages.inquisition_setuping'))
      end

      it_behaves_like 'present file', CLIHelpModule::BASE_CONFIG_FILE_NAME => 'base config'
    end
  end

  describe '#setup' do
    let(:output) { capture { subject.setup } }

    context 'when config file is present' do
      before { create_base_config }

      xit 'show information message' do
      end

      it_behaves_like 'present file', CLIHelpModule::BASE_CONFIG_FILE_NAME => 'base config'
    end

    context 'configuration file is not present' do
      it 'show information message' do
        expect{ subject.setup }.to raise_error(Inquisition::Errors::BaseConfigAbsenseError,
                                               I18n.t('errors.config_absense_error'))
      end
    end
  end
end
