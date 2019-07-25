require 'active_record_doctor/tasks'

RSpec.describe Inquisition::ActiveRecordDoctor::Runner do
  let(:runner) { described_class.new }
  let(:ard_task) { ActiveRecordDoctor::Tasks::UnindexedForeignKeys }
  let(:warning) { { 'unindexed_table' => %w[unindexed_column_1 unindexed_column_1] } }

  let(:message) do
    'unindexed_table has unindexed foreign keys, details: unindexed_column_1, unindexed_column_1'
  end

  before do
    allow(runner).to receive(:load_environment)
    allow(ActiveRecordDoctor::Tasks::Base).to receive(:subclasses).and_return([ard_task])
    allow(ard_task).to receive(:run).and_return([warning, true])
  end

  describe '#call' do
    it 'returns issues array with specific message' do
      expect(runner.call.first.instance_variable_get(:@message)).to eq(message)
    end
  end
end
