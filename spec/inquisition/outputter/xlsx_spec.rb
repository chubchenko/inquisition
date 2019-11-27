RSpec.describe Inquisition::Outputter::XLSX do
  let(:xlsx) { described_class.new(nil) }

  around do |example|
    Inquisition::Configuration.instance.loader.add(xlsx)

    example.run

    Inquisition::Configuration.instance.loader.remove(xlsx)
  end

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
