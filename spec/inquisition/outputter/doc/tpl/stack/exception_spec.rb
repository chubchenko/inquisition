RSpec.describe Inquisition::Outputter::Doc::TPL::Stack::Exception do
  include_examples 'produce', described_class.new

  include_examples 'collection'

  include_examples 'empty?'

  describe '#trouble' do
    subject(:trouble) { described_class.new.trouble }

    it 'returns instance of NoExceptionPkg' do
      expect(trouble).to be_an_instance_of(Inquisition::Outputter::Doc::TPL::Stack::NoExceptionPkg)
    end
  end
end
