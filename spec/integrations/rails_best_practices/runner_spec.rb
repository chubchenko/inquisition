RSpec.describe Inquisition::RailsBestPractices::Runner do
  describe '#call' do
    context 'when call runner and it return errors' do
      before do
        stub_const('Inquisition::RailsBestPractices::Runner::APP_PATH', './spec/dummy')
        stub_const('Inquisition::RailsBestPractices::Runner::NAME_CONFIG', './spec/dummy/rails_best_practices.yml')
      end

      it 'return issue with current arguments' do
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low],
          line: '6',
          runner: be_kind_of(described_class),
          file: File.join(Dir.pwd, 'spec/dummy/config/initializers/backtrace_silencers.rb'),
          message: 'line is longer than 111 characters (112 characters)'
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
