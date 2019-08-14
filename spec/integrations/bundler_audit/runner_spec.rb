RSpec.describe Inquisition::Bundler::Audit::Runner do
  describe '#call' do
    subject(:call_runner) { described_class.new.call }

    before { allow(Dir).to receive(:pwd).and_return(File.join(Dir.pwd, 'spec/dummy')) }

    context 'when runner return errors' do
      let(:errors) { YAML.load_file('./spec/fixtures/data_errors_integration/bundler_audit/errors.yml') }

      it 'return issue with arguments' do
        allow(Inquisition::Issue).to receive(:new)
        call_runner
        errors.each do |error|
          expect(Inquisition::Issue).to have_received(:new).with(
            severity: :low,
            line: '',
            runner: be_kind_of(described_class),
            path: Regexp.new(error['file']),
            message: error['message']
          )
        end
      end
    end
  end
end
