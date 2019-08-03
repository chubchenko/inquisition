RSpec.describe Inquisition::ActiveRecordDoctor::Runner do
  describe '#call' do
    subject(:call_runner) { described_class.new.call }

    context 'when call runner in dummy' do
      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/errors.yml')['active_record_doctor'] }

      before { allow(Dir).to receive(:pwd).and_return(File.join(Dir.pwd, 'spec/dummy')) }

      it 'return count issues' do
        expect(call_runner.count).to eq(3)
      end

      it 'return type issues' do
        expect(call_runner).to all(be_kind_of(Inquisition::Issue))
      end

      it 'return issues with current arguments' do
        allow(Inquisition::Issue).to receive(:new)
        call_runner
        errors.each do |error|
          expect(Inquisition::Issue).to have_received(:new).with(
            severity: :low,
            path: nil,
            line: nil,
            runner: be_kind_of(described_class),
            message: error['message']
          )
        end
      end
    end
  end
end
