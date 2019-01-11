# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::Checkers::AdditionalSoftwareChecker, type: :unit do
  subject { Inquisition::Core::Checkers::AdditionalSoftwareChecker }

  it 'exist NOT_FOUND_TEXT constant' do
    expect(subject.const_get(:NOT_FOUND_TEXT)).to eq('not found')
  end
end
