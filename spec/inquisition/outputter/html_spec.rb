RSpec.describe Inquisition::Outputter::HTML do #create remove meth in outp class
  let(:generator) { instance_double(Inquisition::Outputter::HTML::Generator) }
  let(:html) { described_class.new(nil) }

  before do
    Inquisition::Configuration.instance.loader.add(html)
  end

  describe '#stop' do
    before do
      allow(generator).to receive(:call)
      allow(Inquisition::Outputter::HTML::Generator).to receive(:new).and_return(generator)
      Inquisition::Configuration.instance.fanout.around
    end

    it 'calls instance of html generator' do
      expect(generator).to have_received(:call)
    end
  end
end
