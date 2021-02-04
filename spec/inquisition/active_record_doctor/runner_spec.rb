RSpec.describe Inquisition::ActiveRecordDoctor::Runner do
  include_examples 'enablable', :active_record_doctor

  describe '#call' do
    let(:runner) { described_class.new }
    let(:ard_runner) { 'UnindexedForeignKeysRunner' }
    let(:ard_task) { ActiveRecordDoctor::Tasks::UnindexedForeignKeys }
    let(:warning) { { 'unindexed_table' => %w[unindexed_column_1 unindexed_column_1] } }
    let(:message) do
      'unindexed_table has unindexed foreign keys, details: unindexed_column_1, unindexed_column_1'
    end

    before { allow(ard_task).to receive(:run).and_return([warning, true]) }

    it 'returns issues array with specific message' do
      stub_const('Inquisition::ActiveRecordDoctor::Runner::RUNNERS', [ard_runner])
      expect(runner.call.first.message).to eq(message)
    end
  end
end
