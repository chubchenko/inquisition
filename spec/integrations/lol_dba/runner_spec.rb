RSpec.describe Inquisition::LolDba::Runner do
  describe '#call' do
    context 'when call runner with errors' do
      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/errors.yml')['lol_dba'] }

      before { allow(Dir).to receive(:pwd).and_return(File.join(Dir.pwd, 'spec/dummy')) }

      it 'return index errors' do
        allow(Inquisition::Issue).to receive(:new)
        described_class.call
        errors.each do |error|
          expect(Inquisition::Issue).to have_received(:new).with(
            level: Inquisition::Issue::LEVELS[:low],
            line: nil,
            runner: be_kind_of(described_class),
            file: nil,
            message: error['message']
          )
        end
      end

      it 'return count errors' do
        expect(described_class.call.count).to eq(1)
      end

      it 'return issue' do
        expect(described_class.call).to all(be_kind_of(Inquisition::Issue))
      end
    end
  end
end
