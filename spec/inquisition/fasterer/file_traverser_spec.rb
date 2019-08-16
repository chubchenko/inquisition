RSpec.describe Inquisition::Fasterer::FileTraverser do
  describe '#offenses_grouped_by_type' do
    subject(:method_run) { described_class.new(test_file).offenses_grouped_by_type(analyzer) }

    let(:analyzer) { instance_double('Fasterer::Analyzer', errors: [offense]) }
    let(:offense) do
      instance_double(Fasterer::Offense, explanation: 'error', line_number: 1, offense_name: :sort_vs_sort_by)
    end

    let(:test_file) { 'test_file_path' }

    it 'check upper class' do
      expect(described_class).to be < ::Fasterer::FileTraverser
    end

    context 'when call subject methods' do
      let(:config) { instance_double(Inquisition::Fasterer::Config) }

      before { allow(Inquisition::Fasterer::Config).to receive(:new) { config } }

      it 'call methods' do
        expect(config).to receive_message_chain(:ignored_speedups, :include?)
        method_run
      end
    end
  end
end
