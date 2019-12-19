RSpec.describe Inquisition::Outputter::Doc::Filters::Base do
  describe '#issues' do
    subject(:issues) { described_class.new([], collection_class).issues }

    let(:collection_class) { Inquisition::Outputter::Doc::Filters::Brakeman::Collection }

    it 'returns istance of class' do
      expect(issues).to be_kind_of(collection_class)
    end
  end
end
