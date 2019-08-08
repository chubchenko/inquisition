require 'active_record_doctor/tasks'

RSpec.describe Inquisition::ActiveRecordDoctor::Runner do
  let(:runner) { described_class.new }
  let(:ard_task) { ActiveRecordDoctor::Tasks::UnindexedForeignKeys }
  let(:warning) { { 'unindexed_table' => %w[unindexed_column_1 unindexed_column_1] } }

  let(:message) do
    'unindexed_table has unindexed foreign keys, details: unindexed_column_1, unindexed_column_1'
  end

  describe '#call' do
    it 'returns issues array with specific message' do
      expect(ActiveRecordDoctor::Tasks::Base).to receive(:subclasses).and_return([ard_task])
      expect(ard_task).to receive(:run).and_return([warning, true])
      expect(runner.call.first.instance_variable_get(:@message)).to eq(message)
    end
  end

  include_examples 'enablable', 'active_record_doctor'
end
