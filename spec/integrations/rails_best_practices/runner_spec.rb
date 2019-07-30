RSpec.describe Inquisition::RailsBestPractices::Runner do
  describe '#call' do
    context 'when call runner and it return errors' do
      before { stub_const('Inquisition::RailsBestPractices::Runner::APP_PATH', './spec/dummy') }

      it 'return issue with current arguments' do
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low],
          line: '2',
          runner: be_kind_of(described_class),
          file: File.join(Dir.pwd, 'spec/dummy/db/schema.rb'),
          message: 'always add db index (projects => [user_id])'
        )
        described_class.call
      end

      it 'return issue' do
        expect(described_class.call).to all(be_kind_of(Inquisition::Issue))
      end

      it 'return count issues' do
        expect(described_class.call.count).to eq(1)
      end
    end
  end
end
