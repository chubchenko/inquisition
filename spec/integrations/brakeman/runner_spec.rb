ENV['RAILS_ENV'] = 'test'
require_relative '../../dummy/config/environment'

RSpec.describe Inquisition::Brakeman::Runner do
  describe '#call' do
    before { stub_const('Inquisition::Brakeman::Runner::APP_PATH', './spec/dummy') }

    it 'return issue type object' do
      expect(described_class.call).to all(be_kind_of(Inquisition::Issue))
    end

    it 'return count issues' do
      expect(described_class.call.count).to eq(1)
    end

    it 'return issue with arguments' do
      expect(Inquisition::Issue).to receive(:new).with(
        file: 'app/controllers/application_controller.rb',
        level: 'high',
        line: 5,
        message: 'User controlled method execution',
        runner: be_kind_of(Inquisition::Brakeman::Runner)
      )
      described_class.call
    end
  end
end
