# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::BaseBuilder, type: :unit do
  include AuditorsHelpModule

  subject { Inquisition::Core::BaseBuilder.new(auditors_tree) }

  describe '.call' do
    it 'raise NotImplementedError' do
      expect { subject.call }.to raise_error(NotImplementedError)
    end
  end
end
