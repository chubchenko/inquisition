RSpec.describe Inquisition::Outputter::Doc do
  let(:doc) { described_class.new(nil) }

  around do |example|
    Inquisition::Configuration.instance.loader.add(doc)

    example.run

    Inquisition::Configuration.instance.loader.remove(doc)
  end

  describe '#stop' do
    before do
      allow(Inquisition::Outputter::Doc::Builder).to receive(:call)

      Inquisition::Configuration.instance.fanout.around do
        %w[a b c]
      end
    end

    it do
      expect(Inquisition::Outputter::Doc::Builder).to have_received(:call).with(%w[a b c])
    end
  end
end
