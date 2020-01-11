RSpec.describe Inquisition::LolDba::Runner do
  include_examples 'enablable', :lol_dba

  describe '#call' do
    subject(:runner) { described_class.new }

    context 'when there are no issues' do
      before { allow(LolDba::IndexFinder).to receive(:check_for_indexes).and_return({}) }

      it { expect(runner.call).to be_empty }
    end

    context 'when there is no index on a column in a table' do
      let(:issue) do
        Inquisition::Issue.new(
          severity: Inquisition::Severity::LOW,
          message: 'The following column(s) `user_id` from the `projects` table probably should be indexed',
          runner: runner
        )
      end

      before do
        allow(LolDba::IndexFinder).to receive(:check_for_indexes).and_return('projects' => ['user_id'])
      end

      it 'returns a collection of issues' do
        expect(runner.call).to contain_exactly(issue)
      end
    end

    context 'when there is no composite index on the columns in the table' do
      let(:message) do
        <<-MESSAGE.squish
          The following column(s) `record_id`, `record_type`
          from the `active_storage_attachments` table probably should be indexed
        MESSAGE
      end
      let(:issue) do
        Inquisition::Issue.new(
          severity: Inquisition::Severity::LOW,
          message: message,
          runner: runner
        )
      end

      before do
        allow(LolDba::IndexFinder).to receive(:check_for_indexes).and_return(
          'active_storage_attachments' => [%w[record_id record_type]]
        )
      end

      it 'returns a collection of issues' do
        expect(runner.call).to contain_exactly(issue)
      end
    end
  end
end
