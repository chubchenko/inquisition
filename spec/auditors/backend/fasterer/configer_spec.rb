# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Auditors::Backend::Fasterer::Configer do
  describe '#config_name' do
    subject { Inquisition::Auditors::Backend::Fasterer::Configer.config_name }

    it 'return name of config' do
      expect(subject).to eq('.fasterer.yml')
    end
  end

  describe '#linter_name' do
    subject { Inquisition::Auditors::Backend::Fasterer::Configer.linter_name }

    it 'return linter name' do
      expect(subject).to eq('Fasterer')
    end
  end
end
