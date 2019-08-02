RSpec.describe Inquisition::ActiveRecordDoctor::Runner do
  describe '#call' do
    before { allow(Dir).to receive(:pwd).and_return(File.join(Dir.pwd, 'spec/dummy')) }

    context 'when call runner in dummy' do
      it 'return count issues' do
        expect(described_class.call.count).to eq(3)
      end

      it 'return type issues' do
        expect(described_class.call).to all(be_kind_of(Inquisition::Issue))
      end

      it 'return issues with current arguments' do
        expect(Inquisition::Issue).to receive(:new).with(
          file: nil,
          level: 'low',
          line: nil,
          message: 'active_storage_attachments has unindexed foreign keys, details: record_id',
          runner: be_kind_of(described_class)
        )
        expect(Inquisition::Issue).to receive(:new).with(
          file: nil,
          level: 'low',
          line: nil,
          message: 'ActiveStorage::Attachment has missing presence validation, details: name, record_type, record_id, blob_id',
          runner: be_kind_of(described_class)
        )
        expect(Inquisition::Issue).to receive(:new).with(
          file: nil,
          level: 'low',
          line: nil,
          message: 'ActiveStorage::Blob has missing presence validation, details: key, filename, byte_size, checksum',
          runner: be_kind_of(described_class)
        )
        described_class.call
      end
    end
  end
end
