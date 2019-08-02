require_relative '../../dummy/config/environment'

RSpec.describe Inquisition::Bundler::Audit::Runner do
  describe '#call' do
    before { allow(Dir).to receive(:pwd).and_return(File.join(Dir.pwd, 'spec/dummy')) }

    context 'when runner return errors' do
      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/errors.yml')['bundler_audit'] }

      it 'return issue with arguments' do
        allow(Inquisition::Issue).to receive(:new)
        described_class.call
        errors.each do |error|
          expect(Inquisition::Issue).to have_received(:new).with(
            level: Inquisition::Issue::LEVELS[:low],
            line: '',
            runner: be_kind_of(described_class),
            file: Regexp.new(error['file']),
            message: error['message']
          )
        end
      end

      it 'return type issues' do
        expect(described_class.call).to all(be_kind_of(Inquisition::Issue))
      end

      it 'return count issues' do
        expect(described_class.call.count).to eq(3)
      end
    end
  end
end
