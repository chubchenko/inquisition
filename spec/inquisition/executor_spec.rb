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

  before { allow(output).to receive(:puts) }

  describe '#call' do
    it { expect(described_class.new(options).call(output)).to be_zero }

    it do
      described_class.new(options).call(output)

      expect(output).to have_received(:puts).with(options)
    end
  end
end

RSpec.describe Inquisition::Executor::InitConfig do
  let(:output) { instance_double(StringIO) }

  before do
    allow(output).to receive(:puts)
    allow(Inquisition::Runner).to receive(:descendants).and_return([Inquisition::Brakeman::Runner])
  end

  describe '#call' do
    it { expect(described_class.new.call(output)).to be_zero }

    it do
      described_class.new.call(output)

      expect(output).to have_received(:puts).with(Inquisition::InitConfig.result)
    end
  end
end
