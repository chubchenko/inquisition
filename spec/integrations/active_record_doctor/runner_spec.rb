RSpec.describe Inquisition::ActiveRecordDoctor::Runner do
  describe '#call' do
    let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/errors.yml')['active_record_doctor'] }

    before { allow(Dir).to receive(:pwd).and_return(File.join(Dir.pwd, 'spec/dummy')) }

    context 'when call runner in dummy' do
      it 'return count issues' do
        expect(described_class.call.count).to eq(3)
      end

      it 'return type issues' do
        expect(described_class.call).to all(be_kind_of(Inquisition::Issue))
      end

      it 'return issues with current arguments' do
        allow(Inquisition::Issue).to receive(:new)
        described_class.call
        expect(Inquisition::Issue).to have_received(:new).with(
          file: nil,
          level: Inquisition::Issue::LEVELS[:low],
          line: nil,
          message: 'active_storage_attachments has unindexed foreign keys, details: record_id',
          runner: be_kind_of(described_class)
        )
        expect(Inquisition::Issue).to have_received(:new).with(
          file: nil,
          level: Inquisition::Issue::LEVELS[:low],
          line: nil,
          message: 'ActiveStorage::Attachment has missing presence validation, details: name, record_type, record_id, blob_id',
          runner: be_kind_of(described_class)
        )
        expect(Inquisition::Issue).to have_received(:new).with(
          file: nil,
          level: Inquisition::Issue::LEVELS[:low],
          line: nil,
          message: 'ActiveStorage::Blob has missing presence validation, details: key, filename, byte_size, checksum',
          runner: be_kind_of(described_class)
        )
      end
    end
  end
end
