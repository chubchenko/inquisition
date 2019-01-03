# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::Configer, type: :unit do
  describe '#call' do
    subject { Inquisition::Core::Configer.call }
    let(:output) { capture { subject } }

    it 'show config already exist' do
      enable_output
      allow(Inquisition::Core::Configer).to receive(:config_exists?).and_return(true)
      allow(Inquisition::Core::Configer).to receive(:linter_name).and_return('linter')
      allow(Inquisition::Core::Configer).to receive(:copy_config_file).and_return(true)
      expect(output).to have_output_message(I18n.t('messages.config_already_exist', linter_name: 'linter'))
    end

    xit 'copy config file' do
    end
  end
end
