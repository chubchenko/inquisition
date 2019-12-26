RSpec.shared_examples 'empty?' do
  describe '#empty?' do
    subject(:empty) { described_class.new.empty? }

    context 'when method empty returns true' do
      it 'returns true' do
        expect(empty).to eq(true)
      end
    end

    context 'when method empty returns false' do
      let(:instrumentation) { described_class.new }
      let(:issue) { instance_double(Inquisition::Issue) }

      before do
        allow(described_class).to receive(:new).and_return(instrumentation)
        allow(instrumentation).to receive(:collection).and_return([issue])
      end

      it 'returns false' do
        expect(empty).to eq(false)
      end
    end
  end
end
