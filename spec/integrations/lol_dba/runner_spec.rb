RSpec.describe Inquisition::LolDba::Runner do
  describe '#call' do
    context 'when call runner with errors' do
      before { allow(Dir).to receive(:pwd).and_return(File.join(Dir.pwd, 'spec/dummy')) }

      it 'return index errors' do
        expect(Inquisition::Issue).to receive(:new).with(
          file: nil,
          level: 'low',
          line: nil,
          message: 'You have not index in table `projects`, column `user_id`',
          runner: be_kind_of(described_class)
        )
        described_class.call
      end

      it 'return count errors' do
        expect(described_class.call.count).to eq(1)
      end
    end
  end
end
