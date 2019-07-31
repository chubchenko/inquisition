RSpec.describe Inquisition::Rubycritic::Analysers::Flay do
  describe '#run' do
    subject(:analyser) { described_class.new(analysed_modules['test']) }

    let(:analysed_modules) { { 'test' => [instance_double(RubyCritic::AnalysedModule, path: test_path)] } }
    let(:test_path) { 'spec/inquisition/rubycritic/runner_spec.rb' }
    let(:instance_flay) { instance_double(Flay, hashes: { a: ['path/test'] }) }
    let(:instance_flay_smell) { instance_double(RubyCritic::Analyser::FlaySmells) }

    context 'when run analyser' do
      before do
        instance_variable_set(:@analysed_modules, analysed_modules)
        analyser.instance_variable_set(:@flay, instance_flay)
      end

      it 'check upper class' do
        expect(described_class).to be < ::RubyCritic::Analyser::FlaySmells
      end

      it 'should call hashes and each on analysed_modules' do
        expect(instance_flay).to receive_message_chain(:hashes, :each)
        analyser.run
      end

      it 'should call one time analyze_modules method' do
        expect(analyser).to receive(:analyze_modules)
        analyser.run
      end
    end
  end
end
