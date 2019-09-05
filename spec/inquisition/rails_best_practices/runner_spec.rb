RSpec.describe Inquisition::RailsBestPractices::Runner do
  include_examples 'enablable', 'rails_best_practices'

  describe '#call' do
    subject(:call_runner) { described_class.new.call }

    let(:instance_analyzer) { instance_double(RailsBestPractices::Analyzer, errors: []) }
    let(:errors_analyzer) do
      [
        instance_double(
          RailsBestPractices::Core::Error,
          short_filename: 'test_file',
          line_number: '1',
          message: 'test_message',
          type: 'RailsBestPractices::Reviews::RemoveEmptyHelpersReview'
        )
      ]
    end

    before do
      allow(RailsBestPractices::Analyzer).to receive(:new).and_return(instance_analyzer)
      allow(instance_analyzer).to receive(:analyze).and_return(true)
    end

    context 'when call runner and it returns errors' do
      before { allow(instance_analyzer).to receive(:errors).and_return(errors_analyzer) }

      it 'returns a collection of issues' do
        expect(call_runner).to contain_exactly(
          Inquisition::Issue.new(
            severity: :low,
            category: :unused_code,
            line: 1,
            runner: nil,
            path: errors_analyzer.first.short_filename,
            message: errors_analyzer.first.message
          )
        )
      end
    end

    context 'when call runner without errors' do
      it { is_expected.to be_empty }
    end
  end

  describe 'private method #config_path' do
    let(:analyzer) { instance_double(RailsBestPractices::Analyzer, errors: []) }

    before do
      allow(RailsBestPractices::Analyzer).to receive(:new).and_return(analyzer)
      allow(analyzer).to receive(:analyze).and_return(true)
    end

    context 'when user config exists' do
      before do
        allow(File).to receive(:exist?).and_return(true)
        described_class.new.call
      end

      it do
        expect(::RailsBestPractices::Analyzer).to have_received(:new)
          .with(Rails.root, 'silent' => true, 'config' => 'config/rails_best_practices.yml')
      end
    end

    context 'when user config does not exist' do
      before do
        allow(File).to receive(:exist?).and_return(false)
        described_class.new.call
      end

      it do
        expect(::RailsBestPractices::Analyzer).to have_received(:new)
          .with(Rails.root, 'silent' => true, 'config' => File.join(Inquisition.root, 'config/rails_best_practices/config.yml'))
      end
    end
  end
end
