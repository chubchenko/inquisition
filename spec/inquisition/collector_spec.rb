RSpec.describe Inquisition::Collector do
  describe '#call' do
    subject(:collector) { described_class.new(collection: collection).call }

    context 'when there are no analyzers' do
      let(:collection) { [] }

      it { is_expected.to be_empty }
    end

    context 'when there is at least 1 analyzer' do
      A = Class.new do
        def call
          ['a', ['b', 'c']]
        end
      end

      let(:collection) { [A] }

      it { is_expected.to match_array(['a', 'b', 'c']) }
    end

    # TODO: need to figure out based on which object we need to create a double.
    # context 'when ...' do
    #   let(:analyzer) { instance_double() }
    #
    #   before do
    #     allow(analyzer).to receive(:call).and_return(['a', ['b', 'c']])
    #     allow(MA).to receive(:new).and_return(analyzer)
    #   end
    #
    #   it { is_expected.to match_array(['a', 'b', 'c']) }
    #   it do
    #     collector
    #
    #     expect(analyzer).to have_received(:call)
    #   end
    # end
  end
end
