RSpec.describe Inquisition::Fasterer::Runner do
  describe '#call' do
    subject(:runner) { described_class.call }

    context 'when call with errors' do
      before { stub_const('Inquisition::Fasterer::Runner::APP_PATH', './spec/dummy') }

      it 'return issue with current arguments' do
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low],
          line: 10,
          runner: be_kind_of(described_class),
          file: 'spec/dummy/app/controllers/application_controller.rb',
          message: 'Enumerable#sort is slower than Enumerable#sort_by'
        )
        runner
      end

      it 'return issue' do
        expect(runner).to all(be_kind_of(Inquisition::Issue))
      end

      it 'return count issues' do
        expect(runner.count).to eq(1)
      end
    end
  end
end
