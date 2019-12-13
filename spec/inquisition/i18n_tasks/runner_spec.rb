RSpec.describe Inquisition::I18nTasks::Runner do
  include_examples 'enablable', :i18n_tasks

  describe '#call' do
    subject(:runner) { described_class.new }

    let(:base_task) { instance_double(I18n::Tasks::BaseTask) }
    let(:test_path) { "#{Rails.root}/test" }

    before do
      allow(I18n::Tasks::BaseTask).to receive(:new).and_return(base_task)
      allow(base_task).to receive(:missing_keys).and_return({})
      allow(base_task).to receive(:unused_keys).and_return({})
      allow(base_task).to receive(:config=)
    end

    context 'when there is missing translate' do
      let(:missing_keys_error) { { 'test.key' => missing_error, 'test.key2' => missing_error_without_occurrence } }
      let(:missing_error) do
        instance_double(I18n::Tasks::Data::Tree::Node, value: 'test', data: { type: :error, occurrences: [occurrence] })
      end
      let(:missing_error_without_occurrence) do
        instance_double(I18n::Tasks::Data::Tree::Node, value: 'test2', data: { type: :error, path: test_path })
      end
      let(:occurrence) { instance_double(I18n::Tasks::Scanners::Results::Occurrence, line_num: 1, path: test_path) }

      before { allow(base_task).to receive_message_chain(:missing_keys, :keys).and_return(missing_keys_error) }

      it 'return issues' do
        expect(runner.call).to match_array(
          [
            Inquisition::Issue.new(
              severity: Inquisition::Severity::LOW,
              category: Inquisition::Category::BUG_RISK,
              path: 'test',
              line: 1,
              message: 'missing key: test.key',
              runner: runner,
              aditional_data: nil
            ),
            Inquisition::Issue.new(
              severity: Inquisition::Severity::LOW,
              category: Inquisition::Category::BUG_RISK,
              path: 'test',
              line: nil,
              message: 'missing key: test.key2',
              runner: runner,
              aditional_data: nil
            )
          ]
        )
      end
    end

    context 'when there is unused translate' do
      let(:unused_keys_error) { { 'test.key' => unused_error } }
      let(:unused_error) do
        instance_double(I18n::Tasks::Data::Tree::Node, value: 'test', data: { path: test_path })
      end

      before { allow(base_task).to receive_message_chain(:unused_keys, :keys).and_return(unused_keys_error) }

      it 'returns issues' do
        expect(runner.call).to match_array(
          [
            Inquisition::Issue.new(
              severity: Inquisition::Severity::LOW,
              category: Inquisition::Category::UNUSED_CODE,
              path: 'test',
              line: nil,
              message: 'unused key: test.key, value: test',
              runner: runner,
              aditional_data: nil
            )
          ]
        )
      end
    end

    context 'when call do not return issues' do
      it 'not return issues' do
        expect(runner.call).to be_empty
      end
    end

    context 'when users config exists' do
      before do
        allow(File).to receive(:exist?).and_return(true)
        runner.call
      end

      it { expect(base_task).not_to have_received(:config=) }
    end

    context 'when users config doesnt exist' do
      before do
        allow(File).to receive(:exist?).and_return(false)
        runner.call
      end

      it { expect(base_task).to have_received(:config=) }
    end
  end
end
