# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Errors::BaseConfigAbsenseError do
  subject { Inquisition::Errors::BaseConfigAbsenseError.new }

  it 'return error message' do
    expect(subject.message).to eq('run inquisition install first')
  end
end
