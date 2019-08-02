RSpec.describe Inquisition::Traceroute::Runner do
  describe '#call' do
    context 'when call runner in dummy' do
      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/errors.yml')['traceroute'] }

      before { allow(Dir).to receive(:pwd).and_return(File.join(Dir.pwd, 'spec/dummy')) }

      it 'return count issues' do
        expect(described_class.call.count).to eq(2)
      end

      it 'return type issues' do
        expect(described_class.call).to all(be_kind_of(Inquisition::Issue))
      end

      it 'return issues with current arguments' do
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
    end
  end
end
