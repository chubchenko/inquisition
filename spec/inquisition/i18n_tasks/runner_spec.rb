RSpec.describe Inquisition::I18nTasks::Runner do
  describe '#call' do
    subject(:runner) { described_class.new }

    let(:base_task) { instance_double(I18n::Tasks::BaseTask) }

    before do
      allow(I18n::Tasks::BaseTask).to receive(:new).and_return(base_task)
      allow(base_task).to receive(:unused_keys).and_return({})
    end

    context 'when there is missing translate' do
      let(:missing_keys_error) { { 'test.key' => missing_error, 'test.key2' => missing_error_without_occurrence} }
      let(:missing_error) do
        instance_double(I18n::Tasks::Data::Tree::Node, value: 'test', data: { type: :error, occurrences: [occurrence]})
      end
      let(:missing_error_without_occurrence) do
        instance_double(I18n::Tasks::Data::Tree::Node, value: 'test2', data: { type: :error, path: 'test' })
      end
      let(:occurrence) { instance_double(I18n::Tasks::Scanners::Results::Occurrence, line_num: 1, path: 'test') }

      before do
        allow(base_task).to receive_message_chain(:missing_keys, :keys).and_return(missing_keys_error)
      end

      it 'return issues' do
        expect(runner.call).to match_array(
          [
            Inquisition::Issue.new(
              severity: :low,
              path: 'test',
              line: 1,
              message: 'missing translate key: test.key, value: test',
              runner: runner
            ),
            Inquisition::Issue.new(
              severity: :low,
              path: 'test',
              line: nil,
              message: 'missing translate key: test.key2, value: test2',
              runner: runner
            )
          ]
        )
      end
    end

    context 'when there is unused translate' do
      let(:unused_keys_error) { { 'test.key' => unused_error } }
      let(:unused_error) do
        instance_double(I18n::Tasks::Data::Tree::Node, value: 'test', data: { path: 'test' })
      end

      before do
        allow(base_task).to receive(:missing_keys).and_return({})
        allow(base_task).to receive_message_chain(:unused_keys, :keys).and_return(unused_keys_error)
      end

      it 'returns issues' do
        expect(runner.call).to match_array(
          [
            Inquisition::Issue.new(
              severity: :low,
              path: 'test',
              line: nil,
              message: 'unused key: test.key, value: test',
              runner: runner
            )
          ]
        )
      end
    end

    context 'when call do not return issues' do
      before { allow(base_task).to receive(:missing_keys).and_return({}) }

      it 'not return issues' do
        expect(runner.call).to be_empty
      end
    end
  end
end
