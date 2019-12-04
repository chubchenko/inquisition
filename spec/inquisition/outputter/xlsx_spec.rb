RSpec.describe Inquisition::Outputter::XLSX do
  let(:html) { described_class.new(nil) }

  before { Inquisition::Configuration.instance.loader.add(html) }

  describe '#stop' do
    before do
      allow(Inquisition::Outputter::XLSX::Builder).to receive(:call)

      Inquisition::Configuration.instance.fanout.around do
        %w[a b c]
      end
    end

    it do
      expect(Inquisition::Outputter::XLSX::Builder).to have_received(:call).with(%w[a b c])
    end
  end
end
