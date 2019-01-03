# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Auditors::Backend::Configer do
  describe '#call' do
    subject { Inquisition::Auditors::Backend::Configer.call }

    it_behaves_like 'call callable objects', Inquisition::Auditors::Backend::Configer => 'backend configer'
  end
end
