ENV['RAILS_ENV'] = 'test'
require_relative '../../dummy/config/environment'

RSpec.describe Inquisition::Brakeman::Runner do
  describe '#call' do
    before { stub_const('Inquisition::Brakeman::Runner::APP_PATH', './spec/dummy') }

    it 'return issue type object' do
      expect(described_class.call).to all(be_kind_of(Inquisition::Issue))
    end

    it 'return count issues' do
      expect(described_class.call.count).to eq(2)
    end

    it 'return issue with arguments' do
      expect(Inquisition::Issue).to receive(:new).with(
        file: 'app/controllers/application_controller.rb',
        level: 'high',
        line: 1,
        message: '`protect_from_forgery` should be called in `ApplicationController`',
        runner: be_kind_of(Inquisition::Brakeman::Runner)
      )

      expect(Inquisition::Issue).to receive(:new).with(
        file: 'app/models/application_record.rb',
        level: 'high',
        line: 1,
        message: 'Mass assignment is not restricted using `attr_accessible`',
        runner: be_kind_of(Inquisition::Brakeman::Runner)
      )
      described_class.call
    end
  end
end
