RSpec.describe Inquisition::RailsBestPractices::Runner do
  describe '#call' do
    subject(:call_runner) { described_class.new.call }

    let(:instance_analyzer) { instance_double(RailsBestPractices::Analyzer, errors: []) }
    let(:errors_analyzer) do
      [
        instance_double(
          'RailsBestPractices::Core::Error',
          filename: 'test_file',
          line_number: '1',
          message: 'test_message'
        )
      ]
    end

    before do
      allow(RailsBestPractices::Analyzer).to receive(:new).and_return(instance_analyzer)
      allow(instance_analyzer).to receive(:analyze).and_return(true)
    end

    context 'when call runner and it return errors' do
      before do
        allow(instance_analyzer).to receive(:errors).and_return(errors_analyzer)
      end

      it 'return issue with current arguments' do
        expect(Inquisition::Issue).to receive(:new).with(
          severity: :low,
          line: errors_analyzer.first.line_number,
          runner: be_kind_of(described_class),
          path: errors_analyzer.first.filename,
          message: errors_analyzer.first.message
        ).and_call_original
        call_runner
      end

      it 'return issue' do
        expect(call_runner.first).to be_kind_of(Inquisition::Issue)
      end

      it 'return count issues' do
        expect(call_runner.count).to eq(1)
      end
    end

    context 'when call runner without errors' do
      it 'without errors' do
        is_expected.to be_empty
      end
    end
  end

  include_examples 'enablable', 'rails_best_practices'
end
