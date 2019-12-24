RSpec.describe Inquisition::Outputter::Doc::TPL::Stack::Instrumentation do
  include_examples 'produce', described_class.new

  include_examples 'collection'

  include_examples 'empty?'

  describe '#trouble' do
    subject(:trouble) { described_class.new.trouble }

    it 'returns instance of NoInstrumentationPkg' do
      expect(trouble).to be_an_instance_of(Inquisition::Outputter::Doc::TPL::Stack::NoInstrumentationPkg)
    end
  end
end
