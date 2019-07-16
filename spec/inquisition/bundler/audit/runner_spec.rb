RSpec.describe Inquisition::Bundler::Audit::Runner do
  describe '#call' do
    context 'when update bundle success' do
      before { allow(Bundler::Audit::Database).to receive(:update!).and_return(true) }

      it 'update' do
        expect { described_class.call }.to output(/Updated ruby-advisory-db/).to_stdout
      end
    end

    context 'when update bundle failed' do
      before { allow(Bundler::Audit::Database).to receive(:update!).and_return(false) }

      it 'prints failure message' do
        expect do
          begin described_class.call
          rescue SystemExit
            StandardError
          end
        end.to output(/Failed updating ruby-advisory-db!/).to_stdout
      end
    end

    context 'when check errors with bundler-audit scanner' do
      let(:bundle) { 'unpatched_gems' }
      let(:directory) { File.join('spec', 'fixtures', 'bundle', bundle) }
      let(:scanner) { ::Bundler::Audit::Scanner.new(directory) }
      let(:instance) { instance_double(Bundler::Audit::Scanner) }

      it 'scanner.scan has errors' do
        allow(Bundler::Audit::Scanner).to receive(:new).and_return(scanner)
        expect(described_class.call).not_to be_empty
      end

      it 'scanner.scan has not errors' do
        allow(Bundler::Audit::Scanner).to receive(:new).and_return(instance)
        allow(instance).to receive(:scan).and_return([])
        expect(described_class.call).to eq([])
      end
    end
  end
end
