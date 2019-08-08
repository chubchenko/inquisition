RSpec.describe Inquisition::I18nTasks::Runner do
  describe '#call' do
    subject(:runner) { described_class.new }

    let(:base_task_instance) { instance_double(I18n::Tasks::BaseTask) }
    let(:missing_keys_error) { { 'test.key' => instance_data_for_error } }
    let(:instance_data_for_error) do
      instance_double('I18n::Tasks::Data::Tree::Node', value: 'test', data: { path: 'test_path' })
    end

    before do
      allow(I18n::Tasks::BaseTask).to receive(:new) { base_task_instance }
      allow(base_task_instance).to receive(:unused_keys).and_return({})
    end

    context 'when return issues' do
      before do
        allow(base_task_instance).to receive(:missing_keys) { missing_keys_error }
        allow(missing_keys_error).to receive(:keys).and_return(missing_keys_error)
      end

      it 'return count issues' do
        expect(runner.call.count).to eq(1)
      end

      it 'return type issues' do
        expect(runner.call).to all(be_kind_of(Inquisition::Issue))
      end

      it 'return issues with arguments' do
        allow(Inquisition::Issue).to receive(:new)
        runner.call
        expect(Inquisition::Issue).to have_received(:new).with(
          severity: :low,
          path: 'test_path',
          line: nil,
          message: 'missing translate key: test.key, value: test',
          runner: be_kind_of(described_class)
        )
      end
    end

    context 'when call do not return issues' do
      before { allow(base_task_instance).to receive(:missing_keys).and_return({}) }

      it 'not return issues' do
        expect(runner.call).to be_empty
      end
    end
  end
end
