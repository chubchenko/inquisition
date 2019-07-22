RSpec.describe Inquisition::Logger do
  describe '#log' do
    let(:test_log) { 'test log' }

    context 'when config verbose true' do
      before { allow_any_instance_of(Inquisition::Configuration).to receive(:verbose?).and_return(true) }

      it 'verbose returns true' do
        expect { described_class.log(test_log) }.to output("#{test_log}\n").to_stdout_from_any_process
      end
    end

    context 'when config verbose false' do
      before { allow_any_instance_of(Inquisition::Configuration).to receive(:verbose?).and_return(false) }

      it 'verbose returns false' do
        expect { described_class.log(test_log) }.to output('').to_stdout_from_any_process
      end
    end
  end
end
