RSpec.describe Inquisition::Rubycritic::Runner do
  describe '#call' do
    subject(:result_runner) { described_class.call }

    context 'when runner returns errors' do
      before { stub_const('Inquisition::Rubycritic::Runner::APP_PATH', './spec/dummy') }

      it 'return count issue' do
        expect(result_runner.count).to eq(1)
      end

      it 'return issue' do
        expect(result_runner).to all(be_kind_of(Inquisition::Issue))
      end

      it 'return issue with current arguments' do
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low],
          file: Pathname('spec/dummy/app/controllers/application_controller.rb'),
          line: 9,
          runner: be_kind_of(described_class),
          message: "doesn't depend on instance state (maybe move it to another class?)"
        )
        result_runner
      end
    end
  end
end
