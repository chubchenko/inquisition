RSpec.describe Inquisition::Bundler::Audit::Runner do
  describe '#call' do
    subject(:runner_result) { described_class.call }

    context 'when check errors with bundler-audit scanner' do
      let(:advisory_errors) do
        instance_double(
          Bundler::Audit::Advisory,
          criticality: 'low',
          path: 'path',
          title: 'error'
        )
      end
      let(:scanner_instance) { Bundler::Audit::Scanner.new }
      let(:error_instance) { instance_double(Bundler::Audit::Scanner::UnpatchedGem, advisory: advisory_errors) }
      let(:lockfile) do
        instance_double(
          Bundler::LockfileParser,
          specs: [OpenStruct.new(name: 'actionmailer', version: Gem::Version.new('1.1.5'))],
          sources: []
        )
      end

      before do
        scanner_instance.instance_variable_set(:@lockfile, lockfile)
        allow(Bundler::Audit::Scanner::UnpatchedGem).to receive(:new).and_return(error_instance)
        allow(Bundler::Audit::Scanner).to receive(:new).and_return(scanner_instance)
        allow(Bundler::Audit::Database).to receive(:update!).and_return(true)
      end

      it 'scanner.scan return errors' do
        expect(Inquisition::Issue).to receive(:new).with(
          level: advisory_errors.criticality,
          line: '',
          runner: be_kind_of(described_class),
          file: advisory_errors.path,
          message: advisory_errors.title
        ).and_call_original
        expect(runner_result.first).to be_kind_of(Inquisition::Issue)
        expect(runner_result.count).to eq(1)
      end

      it 'scanner.scan has not errors' do
        allow(Bundler::Audit::Database).to receive(:update!).and_return(true)
        allow(Bundler::Audit::Scanner).to receive(:new).and_return(scanner_instance)
        allow(scanner_instance).to receive(:scan).and_return([])
        expect(described_class.call).to be_empty
      end
    end
  end
end
