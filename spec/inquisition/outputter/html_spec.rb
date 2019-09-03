RSpec.describe Inquisition::Outputter::HTML do
  let(:formatter) { instance_double(Inquisition::Formatters::HtmlFormatter) }
  let(:html) { described_class.new('') }

  describe '#stop' do
    before do
      allow(formatter).to receive(:call)
      allow(Inquisition::Formatters::HtmlFormatter).to receive(:new).and_return(formatter)
      Inquisition::Configuration.instance.loader.add(html)
      Inquisition::Configuration.instance.fanout.around
    end

    it 'calls instance of html formatter' do
      expect(Inquisition::Formatters::HtmlFormatter).to have_received(:new)
      expect(formatter).to have_received(:call)
    end
  end
end
