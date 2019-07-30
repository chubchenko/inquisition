RSpec.describe Inquisition::Plugin do
  subject(:dummy) do
    Class.new do
      include Inquisition::Plugin
    end
  end

  describe '.collection' do
    context 'when there are no descendants' do
      it { expect(dummy.collection).to be_empty }
    end

    context 'when there is at least one descendant' do
      let(:descendant) do
        Class.new(dummy)
      end

      it do
        expect do
          descendant
        end.to change(dummy.collection, :size).by(1)
      end

      it do
        Object.const_set('Descendant', descendant)

        expect(dummy.collection).to match_array(Descendant)

        Object.send(:remove_const, 'Descendant')
      end
    end
  end
end
