RSpec.describe Inquisition::Traceroute::Runner do
  describe '#call' do
    context 'when call runner in dummy' do
      before { allow(Dir).to receive(:pwd).and_return(File.join(Dir.pwd, 'spec/dummy')) }

      it 'return count issues' do
        expect(described_class.call.count).to eq(2)
      end

      it 'return type issues' do
        expect(described_class.call).to all(be_kind_of(Inquisition::Issue))
      end

      it 'return issues with current arguments' do
        expect(Inquisition::Issue).to receive(:new).with(
          file: nil,
          level: 'low',
          line: nil,
          message: 'unreachable action method: application#test_injection_brakeman',
          runner: be_kind_of(described_class)
        )
        expect(Inquisition::Issue).to receive(:new).with(
          file: nil,
          level: 'low',
          line: nil,
          message: 'unreachable action method: application#test_fasterer',
          runner: be_kind_of(described_class)
        )
        described_class.call
      end
    end
  end
end
