RSpec.describe Inquisition::ActiveRecordDoctor::Runner do
  let(:runner) { described_class.new }
  let(:ard_task) { ActiveRecordDoctor::Tasks::UnindexedForeignKeys }
  let(:warning) { { 'unindexed_table' => %w[unindexed_column_1 unindexed_column_1] } }

  let(:message) do
    'unindexed_table has unindexed foreign keys, details: unindexed_column_1, unindexed_column_1'
  end

  before { allow(ard_task).to receive(:run).and_return([warning, true]) }

  describe '#call' do
    it 'returns issues array with specific message' do
      stub_const('Inquisition::ActiveRecordDoctor::Runner::TASKS', ard_task => Inquisition::Category::PERFORMANCE)
      expect(runner.call.first.message).to eq(message)
    end
  end

  include_examples 'enablable', 'active_record_doctor'
end
