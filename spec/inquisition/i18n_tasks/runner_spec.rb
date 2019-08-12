RSpec.describe Inquisition::I18nTasks::Runner do
  describe '#call' do
    subject(:runner) { described_class.new }

    let(:base_task) { instance_double(I18n::Tasks::BaseTask) }
    let(:missing_keys_error) { { 'test.key' => missing_error } }
    let(:unused_keys_error) { { 'test.key' => unused_error } }
    let(:missing_error) do
      instance_double(I18n::Tasks::Data::Tree::Node, value: 'test', data: { type: :error, occurrences: [occurrences_inst]})
    end
    let(:unused_error) do
      instance_double(I18n::Tasks::Data::Tree::Node, value: 'test', data: { path: 'test' })
    end
    let(:occurrences_inst) { instance_double('Occurrence', line_num: 1, path: 'test') }

    before do
      allow(I18n::Tasks::BaseTask).to receive(:new) { base_task }
      allow(base_task).to receive(:unused_keys).and_return({})
    end

    context 'when return issues about missing translate' do
      before do
        allow(base_task).to receive(:missing_keys).and_return(missing_keys_error)
        allow(missing_keys_error).to receive(:keys).and_return(missing_keys_error)
      end

      it 'return issues with arguments' do
        expect(runner.call).to match_array(
          [
            Inquisition::Issue.new(severity: :low,
                                   path: 'test',
                                   line: 1,
                                   message: 'missing translate key: test.key, value: test',
                                   runner: be_kind_of(described_class))
          ]
        )
      end
    end

    context 'when return issues about unused' do
      before do
        allow(base_task).to receive(:missing_keys).and_return({})
        allow(base_task).to receive(:unused_keys).and_return(unused_keys_error)
        allow(unused_keys_error).to receive(:keys).and_return(unused_keys_error)
      end

      it 'return issues with arguments' do
        expect(runner.call).to match_array(
          [
            Inquisition::Issue.new(severity: :low,
                                   path: 'test',
                                   line: nil,
                                   message: 'unused key: test.key, value: test',
                                   runner: be_kind_of(described_class))
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
