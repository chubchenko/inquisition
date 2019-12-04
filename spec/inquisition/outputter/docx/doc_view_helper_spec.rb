RSpec.describe Inquisition::Outputter::Docx::DocViewHelper do
  subject(:define_exists_gems) { described_class.new.define_exists_gems(gems) }

  describe '#define_exists_gems' do
    let(:gems) { ['test_name_gem'] }

    before { allow(Gem).to receive(:loaded_specs).and_return(gem_specification) }

    context 'when gems exists in rails app' do
      let(:gem_specification) { { 'test_name_gem' => 'object' } }

      it 'returns exists gem' do
        expect(define_exists_gems).to eq([gems.first])
      end
    end

    context 'when gems not exists in rails app' do
      let(:gem_specification) { {} }

      it 'returns message about not exists gem' do
        expect(define_exists_gems).to eq([described_class::ERROR_FIND_GEMS_MESSAGE])
      end
    end
  end
end
