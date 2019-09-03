RSpec.describe Inquisition::Executor::Version do
  let(:output) { instance_double(StringIO) }

  before { allow(output).to receive(:puts) }

  describe '#call' do
    it { expect(described_class.new.call(output)).to be_zero }

    it do
      described_class.new.call(output)

      expect(output).to have_received(:puts).with(Inquisition::Version.to_s)
    end
  end
end

RSpec.describe Inquisition::Executor::Help do
  let(:output) { instance_double(StringIO) }
  let(:options) { instance_double(OptionParser) }

  before do
    allow(output).to receive(:puts)

  end

  describe '#call' do
    it { expect(described_class.new(options).call(output)).to be_zero }

    it do
      described_class.new(options).call(output)

      expect(output).to have_received(:puts).with(options)
    end
  end
end
