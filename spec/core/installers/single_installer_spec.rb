# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::Installers::SingleInstaller, type: :unit do
  subject { Inquisition::Core::Installers::SingleInstaller }

  describe '#call' do
    it 'call #run_checkers' do
      expect(subject).to receive(:run_checkers)
      subject.call
    end

    it 'call #run_configurers' do
      expect(subject).to receive(:run_configurers)
      subject.call
    end

    it 'call checker' do
      checker = double('checker')
      allow(subject).to receive(:checkers) { [checker] }
      expect(checker).to receive(:call)
      subject.call
    end

    it 'call configer' do
      configer = double('configer')
      allow(subject).to receive(:configurers) { [configer] }
      expect(configer).to receive(:call)
      subject.call
    end
  end
end
