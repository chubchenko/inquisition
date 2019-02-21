# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::BaseRunner, type: :unit do
  subject { Inquisition::Core::BaseRunner.new }

  describe '.call' do
    it 'raise NotImplementedError' do
      expect { subject.call }.to raise_error(NotImplementedError)
    end
  end
end
