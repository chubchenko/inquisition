RSpec.describe Inquisition::Runner do
  describe '.badge' do
    it { expect(described_class.badge).to be_an_instance_of(Inquisition::Badge) }
  end

  describe '#run' do
    let(:fanout) { instance_double(Inquisition::Fanout) }

    context 'when there are no issues' do
      let(:runner) do
        Class.new(described_class) do
          def call
            []
          end
        end.new
      end

      before { allow(fanout).to receive(:example_passed) }
      after { described_class.collection.delete(runner.class) }

      it do
        runner.run(fanout)

        expect(fanout).to have_received(:example_passed).with(runner)
      end
    end

    context 'when there is at least 1 issue' do
      let(:runner) do
        Class.new(described_class) do
          def call
            ['a']
          end
        end.new
      end

      before { allow(fanout).to receive(:example_failed) }
      after { described_class.collection.delete(runner.class) }

      it do
        runner.run(fanout)

        expect(fanout).to have_received(:example_failed).with(runner)
      end
    end
  end
end
