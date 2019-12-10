RSpec.describe Inquisition::Outputter::HTML do
  let(:html) { described_class.new(nil) }

  around do |example|
    Inquisition::Configuration.instance.loader.add(html)

    example.run

    Inquisition::Configuration.instance.loader.remove(html)
  end

  describe '#stop' do
    before do
      allow(Inquisition::Outputter::HTML::Builder).to receive(:call)

      Inquisition::Configuration.instance.fanout.around do
        %w[a b c]
      end
    end

    it do
      expect(Inquisition::Outputter::HTML::Builder).to have_received(:call).with(%w[a b c])
    end
  end
end
