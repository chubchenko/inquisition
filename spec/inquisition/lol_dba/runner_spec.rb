RSpec.describe Inquisition::LolDba::Runner do
  describe '#call' do
    let(:instance) { described_class.new }
    let(:index_error) { { 'tasks' => ['project_id'] } }

    before do
      allow(described_class).to receive(:new).and_return(instance)
      allow(instance).to receive(:load_environment).and_return(true)
    end

    context 'when call runner with errors' do
      it 'return index errors' do
        allow(LolDba::IndexFinder).to receive(:check_for_indexes).and_return(index_error)
        expect(Inquisition::Issue).to receive(:new).with(
          path: nil, severity: :low, line: nil,
          message: 'You have not index in table `tasks`, column `project_id`',
          runner: be_kind_of(described_class)
        ).and_call_original
        expect(described_class.new.call.count).to eq(1)
      end
    end

    context 'when call runner and it return not one error' do
      it 'without errors' do
        allow(LolDba::IndexFinder).to receive(:check_for_indexes).and_return({})
        expect(described_class.new.call).to be_empty
      end
    end
  end

  include_examples 'enablable', 'lol_dba'
end
