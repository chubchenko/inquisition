require 'active_record_doctor/tasks'

RSpec.describe Inquisition::ActiveRecordDoctor::Runner do
  let(:runner) { described_class.new }
  let(:ard_module) { ActiveRecordDoctor::Tasks::UnindexedForeignKeys }
  let(:warning) { { 'unindexed_table' => %w[unindexed_column_1 unindexed_column_1] } }

  let(:message) do
    'unindexed_table has unindexed foreign keys, details: unindexed_column_1, unindexed_column_1'
  end

  let(:issues) do
    [Inquisition::Issue.new(level: Inquisition::Issue::LEVELS[:low], file: nil,
                            line: nil, message: message, runner: nil)]
  end

  before do
    allow(ActiveRecord::Base).to receive(:establish_connection)
    allow(YAML).to receive(:load).and_return({})
    allow(IO).to receive(:read)
    allow(Rails).to receive(:env)
    allow(ActiveRecordDoctor::Tasks::Base).to receive(:subclasses).and_return([ard_module])
    allow(ard_module).to receive(:run).and_return([warning, true])
  end

  describe '#call' do
    it 'establish connection' do
      runner.call
      expect(ActiveRecord::Base).to have_received(:establish_connection)
    end

    it 'returns issues array with specific message' do
      expect(runner.call.first.instance_variable_get(:@message)).to eq(message)
    end
  end
end
