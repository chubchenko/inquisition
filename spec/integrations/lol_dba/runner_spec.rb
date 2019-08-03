RSpec.describe Inquisition::LolDba::Runner do
  describe '#call' do
    subject(:call_runner) { described_class.new.call }

    context 'when call runner with errors' do
      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/errors.yml')['lol_dba'] }

      before { allow(Dir).to receive(:pwd).and_return(File.join(Dir.pwd, 'spec/dummy')) }

      it 'return index errors' do
        allow(Inquisition::Issue).to receive(:new)
        call_runner
        errors.each do |error|
          expect(Inquisition::Issue).to have_received(:new).with(
            severity: :low,
            line: nil,
            runner: be_kind_of(described_class),
            path: nil,
            message: error['message']
          )
        end
      end

      it 'return count errors' do
        expect(call_runner.count).to eq(1)
      end

      it 'return issue' do
        expect(call_runner).to all(be_kind_of(Inquisition::Issue))
      end
    end
  end
end
