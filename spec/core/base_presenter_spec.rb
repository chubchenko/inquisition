# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Inquisition::Core::BasePresenter do
  include AuditorsHelpModule

  subject { Inquisition::Core::BasePresenter.new(auditors_tree) }

  describe 'constants' do
    it 'have CIRCLE_CHART_COLORS constant' do
      expect(subject.class).to be_const_defined(:CIRCLE_CHART_COLORS)
    end
  end

  describe '.call' do
    it 'call .build_presenter' do
      expect(subject).to receive(:build_presenter)
      subject.call
    end

    it 'raise NotImplementedError' do
      expect { subject.build_presenter }.to raise_error(NotImplementedError)
    end
  end
end
