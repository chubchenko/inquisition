RSpec.describe Inquisition::LolDba::MissingIndex do
  describe '#to_h' do
    subject(:missing_index) { described_class.new(arguments) }

    context 'when there is no index on a column in a table' do
      let(:arguments) do
        {
          table: 'projects',
          columns: 'user_id'
        }
      end

      let(:options) do
        {
          severity: ::Inquisition::Severity::LOW,
          message: 'The following column(s) `user_id` from the `projects` table probably should be indexed'
        }
      end

      it { expect(missing_index.to_h).to include(options) }
    end

    context 'when there is no composite index on the columns in the table' do
      let(:arguments) do
        {
          table: 'active_storage_attachments',
          columns: %w[record_id record_type]
        }
      end

      let(:message) do
        <<-MESSAGE.squish
          The following column(s) `record_id`, `record_type`
          from the `active_storage_attachments` table probably should be indexed
        MESSAGE
      end
      let(:options) do
        {
          severity: Inquisition::Severity::LOW,
          message: message
        }
      end

      it { expect(missing_index.to_h).to include(options) }
    end
  end
end
