require 'spec_helper'

RSpec.describe Inquisition::Core::BasePresenter do
  include AuditorsHelpModule

  subject { Inquisition::Core::BasePresenter.new }

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
