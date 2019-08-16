RSpec.describe Inquisition::Outputter::Progress do
  let(:progress) { described_class.new(output) }

  let(:output) { StringIO.new }

  before { Inquisition::Configuration.instance.loader.add(progress) }

  describe '#example_passed' do
    before { Inquisition::Configuration.instance.fanout.example_passed }

    it 'prints a . on example_passed' do
      expect(output.string).to eq("\e[32m.\e[0m")
    end
  end

  describe '#example_failed' do
    before { Inquisition::Configuration.instance.fanout.example_failed }

    it 'prints a F on example_failed' do
      expect(output.string).to eq("\e[31mF\e[0m")
    end
  end

  describe '#stop' do
    before { Inquisition::Configuration.instance.fanout.around }

    it 'pushes nothing on stop' do
      expect(output.string).to eq("\n")
    end
  end
end
