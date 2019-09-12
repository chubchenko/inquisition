RSpec.describe Inquisition::Outputter::HTML do
  let(:formatter) { instance_double(Inquisition::Outputter::HtmlOutput::Formatter) }
  let(:html) { described_class.new('') }

  describe '#stop' do
    before do
      allow(formatter).to receive(:call)
      allow(Inquisition::Outputter::HtmlOutput::Formatter).to receive(:new).and_return(formatter)
      Inquisition::Configuration.instance.loader.add(html)
      Inquisition::Configuration.instance.fanout.around
    end

    it 'calls instance of html formatter' do
      expect(Inquisition::Outputter::HtmlOutput::Formatter).to have_received(:new)
      expect(formatter).to have_received(:call)
    end
  end
end
