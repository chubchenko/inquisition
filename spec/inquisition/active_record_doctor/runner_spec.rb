require 'active_record_doctor/tasks'

RSpec.describe Inquisition::ActiveRecordDoctor::Runner do
  let(:runner)   { described_class.new }
  let(:ard_task) { ActiveRecordDoctor::Tasks::UnindexedForeignKeys }
  let(:warning)  { { 'unindexed_table' => %w[unindexed_column_1 unindexed_column_1] } }

  let(:environment)      { 'target_environment' }
  let(:loaded_db_config) { { test_key: 'test_value' } }
  let(:full_db_config)   { { environment => loaded_db_config, 'foo' => { bar: 'baz' } } }

  let(:message) do
    'unindexed_table has unindexed foreign keys, details: unindexed_column_1, unindexed_column_1'
  end

  before do
    allow(YAML).to receive(:load).and_return(full_db_config)
    allow(IO).to receive(:read)
    allow(Rails).to receive(:env).and_return(environment)
    allow(ActiveRecordDoctor::Tasks::Base).to receive(:subclasses).and_return([ard_task])
    allow(ard_task).to receive(:run).and_return([warning, true])
  end

  describe '#call' do
    it 'returns issues array with specific message' do
      expect(ActiveRecord::Base).to receive(:establish_connection).with(loaded_db_config)
      expect(runner.call.first.instance_variable_get(:@message)).to eq(message)
    end
  end
end
