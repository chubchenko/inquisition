RSpec.describe Inquisition::Rubycritic::Analysers::Flog do
  describe '#run' do
    subject(:analyser) { described_class.new(analysed_modules) }

    let(:analysed_modules) { [instance_double(RubyCritic::AnalysedModule)] }

    context 'when run analyser' do
      before { instance_variable_set(:@analysed_modules, analysed_modules) }

      it 'check upper class' do
        expect(described_class).to be < ::RubyCritic::Analyser::FlogSmells
      end

      it 'should call each on analysed_modules' do
        expect(analysed_modules).to receive(:each)
        analyser.run
      end

      it 'should call add_smells_to method one time' do
        expect(analyser).to receive(:add_smells_to).with(analysed_modules.first)
        analyser.run
      end
    end
  end
end
