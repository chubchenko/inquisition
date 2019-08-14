RSpec.describe Inquisition::RailsBestPractices::Runner do
  include_examples 'enablable', 'rails_best_practices'

  describe '#call' do
    subject(:call_runner) { described_class.new.call }

    let(:instance_analyzer) { instance_double(RailsBestPractices::Analyzer, errors: []) }
    let(:errors_analyzer) do
      [
        instance_double(
          'RailsBestPractices::Core::Error',
          short_filename: 'test_file',
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
      before { allow(instance_analyzer).to receive(:errors).and_return(errors_analyzer) }

      it 'returns a collection of issues' do

        expect(call_runner).to contain_exactly(Inquisition::Issue.new(
          severity: :low,
          line: 1,
          runner: nil,
          path: errors_analyzer.first.short_filename,
          message: errors_analyzer.first.message)
        )
      end
    end

    context 'when call runner without errors' do
      it { is_expected.to be_empty }
    end
  end

  describe 'private method #config_path' do
    context 'when user config exist' do
      let(:path_to_user_config) { Inquisition::RailsBestPractices::Runner::USER_CONFIG_PATH }

      it 'return user config path' do
        allow(File).to receive(:exist?).and_return(true)
        expect(described_class.new.send(:config_path)).to eq(path_to_user_config)
      end
    end

    context 'when user config not exist' do
      let(:path_to_config_inquisition) do
        File.join(Inquisition.root, Inquisition::RailsBestPractices::Runner::INQUISITION_CONFIG_PATH)
      end

      it 'return inquisition config path' do
        allow(File).to receive(:exist?).and_return(false)
        expect(described_class.new.send(:config_path)).to eq(path_to_config_inquisition)
      end
    end
  end
end
