RSpec.describe Inquisition::RailsBestPractices::Runner do
  describe '#call' do
    subject(:call_runner) { described_class.new.call }

    context 'when call runner and it return errors' do
      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/errors.yml')['rails_best_practices'] }

      before do
        stub_const('Inquisition::RailsBestPractices::Runner::NAME_CONFIG', './spec/dummy/rails_best_practices.yml')
      end

      it 'return issue with current arguments' do
        allow(Inquisition::Issue).to receive(:new)
        call_runner
        errors.each do |error|
          expect(Inquisition::Issue).to have_received(:new).with(
            severity: :low,
            line: error['line'],
            runner: be_kind_of(described_class),
            path: File.join(Dir.pwd, error['file']),
            message: error['message']
          )
        end
      end

      it 'return issue' do
        expect(call_runner).to all(be_kind_of(Inquisition::Issue))
      end

      it 'return count issues' do
        expect(call_runner.count).to eq(1)
      end
    end
  end
end
