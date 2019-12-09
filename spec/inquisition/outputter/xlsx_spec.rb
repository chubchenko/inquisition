RSpec.describe Inquisition::Outputter::Xlsx do
  let(:xlsx) { described_class.new(nil) }

  around do |example|
    Inquisition::Configuration.instance.loader.add(xlsx)

    example.run

    Inquisition::Configuration.instance.loader.remove(xlsx)
  end

  describe '#stop' do
    before do
      allow(Inquisition::Outputter::Xlsx::Builder).to receive(:call)

      Inquisition::Configuration.instance.fanout.around do
        %w[a b c]
      end
    end

    it do
      expect(Inquisition::Outputter::Xlsx::Builder).to have_received(:call).with(%w[a b c])
    end
  end
end
